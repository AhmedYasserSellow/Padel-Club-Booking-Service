import 'package:booking/bloc/cubit.dart';
import 'package:booking/bloc/states.dart';
import 'package:booking/components/constants.dart';
import 'package:booking/components/notifications.dart';
import 'package:booking/components/theme.dart';
import 'package:booking/components/widgets/default_button.dart';
import 'package:booking/components/widgets/text_form_field.dart';
import 'package:booking/layouts/home_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController phone = TextEditingController();

  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const BackButtonIcon(),
                    color: textColor,
                    onPressed: () => AppCubit.get(context)
                      ..loginPageState(0)
                      ..buttonIsLoading(false),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              myTextFormField(
                textStyleColor: textColor,
                labelColor: textColor,
                focusColor: textColor,
                color: textColor,
                controller: name,
                type: TextInputType.text,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return "your name is required";
                  }

                  return null;
                },
                label: 'Your Name',
                prefix: Icons.account_circle,
                context: context,
              ),
              const SizedBox(
                height: 12,
              ),
              myTextFormField(
                textStyleColor: textColor,
                labelColor: textColor,
                focusColor: textColor,
                color: textColor,
                limit: 11,
                context: context,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return "your phone number is required";
                  }

                  if (!value.startsWith('01') || value.length != 11) {
                    return 'enter a valid phone number';
                  }
                  return null;
                },
                controller: phone,
                type: TextInputType.phone,
                label: "Phone Number",
                prefix: Icons.phone,
              ),
              const SizedBox(
                height: 24,
              ),
              defaultButton(
                isLoading: AppCubit.get(context).isLoading,
                color: textColor,
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    if (!AppCubit.get(context).isLoading) {
                      AppCubit.get(context).buttonIsLoading(true);
                      try {
                        final prefs = await SharedPreferences.getInstance();
                        UserCredential user =
                            await FirebaseAuth.instance.signInAnonymously();
                        prefs.setString(yourName, name.text);
                        prefs.setString(yourPhone, phone.text);
                        prefs.setBool(dev, false);
                        prefs.setBool(isLoggedIn, true);
                        prefs.setString(id, user.user!.uid);
                        await sendNewUserNotification(
                          name: name.text,
                        );
                        await FirebaseFirestore.instance
                            .collection('App Users')
                            .doc(user.user!.uid)
                            .set(
                                {
                              'ID': user.user!.uid,
                              'Name': name.text,
                              'Phone Number': phone.text,
                              'Last Message': DateTime.now(),
                              'Message': '',
                            },
                                SetOptions(
                                  merge: true,
                                ));
                        await FirebaseMessaging.instance
                            .subscribeToTopic(user.user!.uid);
                        await FirebaseMessaging.instance
                            .subscribeToTopic('offers');
                        if (context.mounted) {
                          Navigator.pushReplacementNamed(
                            context,
                            HomePage.id,
                          );
                          AppCubit.get(context).buttonIsLoading(false);
                        }
                      } catch (e) {
                        if (context.mounted) {
                          AppCubit.get(context).buttonIsLoading(false);
                          noInternetSnackBar(context);
                        }
                      }
                    }
                  }
                },
                text: 'Sign In',
                buttonTextColor: const Color.fromRGBO(0, 0, 0, 1),
              ),
            ],
          ),
        );
      },
    );
  }
}

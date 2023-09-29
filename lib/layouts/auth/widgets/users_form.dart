import 'package:booking/core/utilities/constants/constants.dart';
import 'package:booking/core/utilities/services/notifications.dart';
import 'package:booking/core/utilities/services/service_locator.dart';
import 'package:booking/core/widgets/no_internet_snackbar.dart';
import 'package:booking/layouts/auth/logic/auth_cubit.dart';
import 'package:booking/core/utilities/theme/theme.dart';
import 'package:booking/core/widgets/default_button.dart';
import 'package:booking/core/widgets/text_form_field.dart';
import 'package:booking/layouts/home/home_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const BackButtonIcon(),
                    color: AppTheme.whiteTextColor,
                    onPressed: () => AuthCubit.get(context)
                      ..loginPageState(0)
                      ..buttonIsLoading(false),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              myTextFormField(
                textStyleColor: AppTheme.whiteTextColor,
                labelColor: AppTheme.whiteTextColor,
                focusColor: AppTheme.whiteTextColor,
                color: AppTheme.whiteTextColor,
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
                textStyleColor: AppTheme.whiteTextColor,
                labelColor: AppTheme.whiteTextColor,
                focusColor: AppTheme.whiteTextColor,
                color: AppTheme.whiteTextColor,
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
                isLoading: AuthCubit.get(context).isLoading,
                color: AppTheme.whiteTextColor,
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    if (!AuthCubit.get(context).isLoading) {
                      AuthCubit.get(context).buttonIsLoading(true);
                      try {
                        final prefs = await GetInstance.prefs;
                        UserCredential user =
                            await GetInstance.auth.signInAnonymously();
                        prefs.setString(PrefsKeys.kName, name.text);
                        prefs.setString(PrefsKeys.kPhone, phone.text);
                        prefs.setBool(PrefsKeys.kAdmin, false);
                        prefs.setBool(PrefsKeys.kIsLoggedIn, true);
                        prefs.setString(PrefsKeys.kFirebaseID, user.user!.uid);
                        await NotificationService.sendNewUserNotification(
                          name: name.text,
                        );
                        await GetInstance.store
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
                        await GetInstance.msg.subscribeToTopic(user.user!.uid);
                        await GetInstance.msg.subscribeToTopic('offers');
                        if (context.mounted) {
                          Navigator.pushReplacementNamed(
                            context,
                            HomeLayout.id,
                          );
                          AuthCubit.get(context).buttonIsLoading(false);
                        }
                      } catch (e) {
                        if (context.mounted) {
                          AuthCubit.get(context).buttonIsLoading(false);
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

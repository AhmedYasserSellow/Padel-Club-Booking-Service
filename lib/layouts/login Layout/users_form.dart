import 'package:booking/bloc/cubit.dart';
import 'package:booking/components/constants.dart';
import 'package:booking/components/theme.dart';
import 'package:booking/layouts/home_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import '../../components/widgets/default_button.dart';

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
    return Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            children: [
              BackButton(
                color: textColor,
                onPressed: () => AppCubit.get(context).loginPageState(0),
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
            color: textColor,
            onTap: () async {
              if (formKey.currentState!.validate()) {
                try {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString(yourName, name.text);
                  prefs.setString(yourPhone, phone.text);
                  prefs.setBool(dev, false);
                  prefs.setBool(isLoggedIn, true);

                  FirebaseMessaging.instance.subscribeToTopic('offers');
                  UserCredential user =
                      await FirebaseAuth.instance.signInAnonymously();
                  prefs.setString(
                    id,
                    user.user!.uid,
                  );
                  FirebaseFirestore.instance
                      .collection('App Users')
                      .doc(user.user!.uid)
                      .set(
                          {
                        'ID': user.user!.uid,
                        'Name': name.text,
                        'Phone Number': phone.text,
                      },
                          SetOptions(
                            merge: true,
                          ));
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(
                      context,
                      HomePage.id,
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    noInternetSnackBar(context);
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
  }
}

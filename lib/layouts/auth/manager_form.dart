import 'package:booking/bloc/cubit.dart';
import 'package:booking/bloc/states.dart';
import 'package:booking/components/constants.dart';
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

class ManagersForm extends StatefulWidget {
  const ManagersForm({super.key});

  @override
  State<ManagersForm> createState() => _ManagersFormState();
}

class _ManagersFormState extends State<ManagersForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController phone = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Users').snapshots(),
            builder: (context, snapshot) {
              String phone1,
                  pass1,
                  name1,
                  phone2,
                  pass2,
                  name2,
                  phone3,
                  pass3,
                  name3,
                  phone4,
                  pass4,
                  name4,
                  phone5,
                  name5,
                  pass5;

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
                      limit: 11,
                      context: context,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "your mobile number is required";
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
                      height: 12,
                    ),
                    myTextFormField(
                      textStyleColor: textColor,
                      labelColor: textColor,
                      focusColor: textColor,
                      color: textColor,
                      isHidden: AppCubit.get(context).isHidden,
                      controller: password,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "your password is required";
                        }

                        if (value.length < 8) {
                          return 'password is too short';
                        }
                        return null;
                      },
                      label: 'Password',
                      prefix: Icons.lock,
                      suffix: IconButton(
                          onPressed: () {
                            AppCubit.get(context).passwordState();
                          },
                          icon: Icon(
                            AppCubit.get(context).isHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                          )),
                      context: context,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    defaultButton(
                        isLoading: AppCubit.get(context).isLoading,
                        color: textColor,
                        onTap: () async {
                          bool wrongData = false;
                          String phoneNumber = phone.text;
                          String lock = password.text;

                          phone1 = snapshot.data!.docs[0]['phone'];
                          phone2 = snapshot.data!.docs[1]['phone'];
                          phone3 = snapshot.data!.docs[2]['phone'];
                          phone4 = snapshot.data!.docs[3]['phone'];
                          phone5 = snapshot.data!.docs[4]['phone'];
                          name1 = snapshot.data!.docs[0]['name'];
                          name2 = snapshot.data!.docs[1]['name'];
                          name3 = snapshot.data!.docs[2]['name'];
                          name4 = snapshot.data!.docs[3]['name'];
                          name5 = snapshot.data!.docs[4]['name'];
                          pass1 = snapshot.data!.docs[0]['pass'];
                          pass2 = snapshot.data!.docs[1]['pass'];
                          pass3 = snapshot.data!.docs[2]['pass'];
                          pass4 = snapshot.data!.docs[3]['pass'];
                          pass5 = snapshot.data!.docs[4]['pass'];
                          if (AppCubit.get(context).isLoading) {
                          } else {
                            try {
                              if (formKey.currentState!.validate()) {
                                AppCubit.get(context).buttonIsLoading(true);
                                final prefs =
                                    await SharedPreferences.getInstance();
                                if ((phoneNumber == phone1 && lock == pass1) ||
                                    (phoneNumber == phone2 && lock == pass2) ||
                                    (phoneNumber == phone3 && lock == pass3) ||
                                    (phoneNumber == phone4 && lock == pass4) ||
                                    (phoneNumber == phone5 && lock == pass5)) {
                                  if (phoneNumber == phone1) {
                                    prefs.setString(yourName, name1);
                                    prefs.setString(yourPhone, phoneNumber);
                                  } else if (phoneNumber == phone2) {
                                    prefs.setString(yourName, name2);
                                    prefs.setString(yourPhone, phoneNumber);
                                  } else if (phoneNumber == phone3) {
                                    prefs.setString(yourName, name3);
                                    prefs.setString(yourPhone, phoneNumber);
                                  } else if (phoneNumber == phone4) {
                                    prefs.setString(yourName, name4);
                                    prefs.setString(yourPhone, phoneNumber);
                                  } else if (phoneNumber == phone5) {
                                    prefs.setString(yourName, name5);
                                    prefs.setString(yourPhone, phoneNumber);
                                  }
                                  prefs.setBool(isLoggedIn, true);
                                  prefs.setBool(dev, true);
                                  prefs.setString(id, '0');
                                  await FirebaseAuth.instance
                                      .signInAnonymously();
                                  FirebaseMessaging.instance
                                      .subscribeToTopic('notify');
                                  FirebaseMessaging.instance
                                      .subscribeToTopic('newUsers');
                                  FirebaseMessaging.instance
                                      .subscribeToTopic('0');
                                  if (context.mounted) {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      HomePage.id,
                                    );
                                    AppCubit.get(context)
                                        .buttonIsLoading(false);
                                  }
                                } else {
                                  throw Exception(wrongData = true);
                                }
                              }
                            } catch (e) {
                              if (wrongData == true) {
                                await Future.delayed(
                                    const Duration(milliseconds: 500));
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      backgroundColor:
                                          const Color.fromRGBO(244, 67, 54, 1),
                                      content: Text(
                                        'wrong phone or password please try again',
                                        style: TextStyle(color: textColor),
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                if (context.mounted) {
                                  noInternetSnackBar(context);
                                }
                              }
                              if (context.mounted) {
                                AppCubit.get(context).buttonIsLoading(false);
                              }
                            }
                          }
                        },
                        text: 'Sign In',
                        buttonTextColor: const Color.fromRGBO(0, 0, 0, 1)),
                  ],
                ),
              );
            });
      },
    );
  }
}
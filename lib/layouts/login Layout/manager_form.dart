import 'package:booking/bloc/cubit.dart';
import 'package:booking/bloc/states.dart';
import 'package:booking/components/constants.dart';
import 'package:booking/components/theme.dart';
import 'package:booking/layouts/home_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import '../../components/widgets/default_button.dart';

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
            stream: connection.onStatusChange,
            builder: (context, ethernetSnapshot) {
              return StreamBuilder(
                  stream: Stream.fromFuture(connection.connectionStatus),
                  builder: (context, internetSnapshot) {
                    return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Users')
                            .snapshots(),
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
                              name4;

                          return Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    BackButton(
                                      color: textColor,
                                      onPressed: () => AppCubit.get(context)
                                          .loginPageState(0),
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

                                    if (!value.startsWith('01') ||
                                        value.length != 11) {
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
                                    color: textColor,
                                    onTap: () async {
                                      String phoneNumber = phone.text;
                                      String lock = password.text;

                                      phone1 = snapshot.data!.docs[0]['phone'];
                                      phone2 = snapshot.data!.docs[1]['phone'];
                                      phone3 = snapshot.data!.docs[2]['phone'];
                                      phone4 = snapshot.data!.docs[3]['phone'];
                                      name1 = snapshot.data!.docs[0]['name'];
                                      name2 = snapshot.data!.docs[1]['name'];
                                      name3 = snapshot.data!.docs[2]['name'];
                                      name4 = snapshot.data!.docs[3]['name'];
                                      pass1 = snapshot.data!.docs[0]['pass'];
                                      pass2 = snapshot.data!.docs[1]['pass'];
                                      pass3 = snapshot.data!.docs[2]['pass'];
                                      pass4 = snapshot.data!.docs[3]['pass'];
                                      if (formKey.currentState!.validate()) {
                                        if (snapshot.hasData &&
                                            (internetSnapshot.data ==
                                                    InternetConnectionStatus
                                                        .connected ||
                                                ethernetSnapshot.data ==
                                                    InternetConnectionStatus
                                                        .connected)) {
                                          final prefs = await SharedPreferences
                                              .getInstance();
                                          if ((phoneNumber == phone1 &&
                                                  lock == pass1) ||
                                              (phoneNumber == phone2 &&
                                                  lock == pass2) ||
                                              (phoneNumber == phone3 &&
                                                  lock == pass3) ||
                                              (phoneNumber == phone4 &&
                                                  lock == pass4)) {
                                            if (phoneNumber == phone1) {
                                              prefs.setString(yourName, name1);
                                              prefs.setString(
                                                  yourPhone, phoneNumber);
                                              prefs.setString(id,
                                                  snapshot.data!.docs[0]['ID']);
                                            } else if (phoneNumber == phone2) {
                                              prefs.setString(yourName, name2);
                                              prefs.setString(
                                                  yourPhone, phoneNumber);
                                              prefs.setString(id,
                                                  snapshot.data!.docs[1]['ID']);
                                            } else if (phoneNumber == phone3) {
                                              prefs.setString(yourName, name3);
                                              prefs.setString(
                                                  yourPhone, phoneNumber);
                                              prefs.setString(id,
                                                  snapshot.data!.docs[2]['ID']);
                                            } else if (phoneNumber == phone4) {
                                              prefs.setString(yourName, name4);
                                              prefs.setString(
                                                  yourPhone, phoneNumber);
                                              prefs.setString(id,
                                                  snapshot.data!.docs[3]['ID']);
                                            }
                                            prefs.setBool(isLoggedIn, true);
                                            prefs.setBool(dev, true);

                                            FirebaseMessaging.instance
                                                .subscribeToTopic('notify');
                                            if (context.mounted) {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                HomePage.id,
                                              );
                                            }
                                          } else {
                                            if (context.mounted) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  duration: const Duration(
                                                      milliseconds: 1500),
                                                  backgroundColor:
                                                      const Color.fromRGBO(
                                                          244, 67, 54, 1),
                                                  content: Text(
                                                    'wrong phone or password please try again',
                                                    style: TextStyle(
                                                        color: textColor),
                                                  ),
                                                ),
                                              );
                                            }
                                          }
                                        } else {
                                          noInternetSnackBar(context);
                                        }
                                      }
                                    },
                                    text: 'Sign In',
                                    buttonTextColor:
                                        const Color.fromRGBO(0, 0, 0, 1)),
                              ],
                            ),
                          );
                        });
                  });
            });
      },
    );
  }
}

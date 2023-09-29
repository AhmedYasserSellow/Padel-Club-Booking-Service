import 'package:booking/core/utilities/constants/constants.dart';
import 'package:booking/core/utilities/services/service_locator.dart';
import 'package:booking/core/widgets/no_internet_snackbar.dart';
import 'package:booking/layouts/auth/logic/auth_cubit.dart';
import 'package:booking/core/utilities/theme/theme.dart';
import 'package:booking/core/widgets/default_button.dart';
import 'package:booking/core/widgets/text_form_field.dart';
import 'package:booking/layouts/home/home_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return StreamBuilder(
            stream: GetInstance.store.collection('Users').snapshots(),
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
                      textStyleColor: AppTheme.whiteTextColor,
                      labelColor: AppTheme.whiteTextColor,
                      focusColor: AppTheme.whiteTextColor,
                      color: AppTheme.whiteTextColor,
                      isHidden: AuthCubit.get(context).isHidden,
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
                            AuthCubit.get(context).passwordState();
                          },
                          icon: Icon(
                            AuthCubit.get(context).isHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                          )),
                      context: context,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    defaultButton(
                        isLoading: AuthCubit.get(context).isLoading,
                        color: AppTheme.whiteTextColor,
                        onTap: () async {
                          bool wrongData = false;
                          String phoneNumber = phone.text;
                          String lock = password.text;

                          if (AuthCubit.get(context).isLoading) {
                          } else {
                            try {
                              if (formKey.currentState!.validate()) {
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
                                AuthCubit.get(context).buttonIsLoading(true);
                                final prefs = await GetInstance.prefs;
                                if ((phoneNumber == phone1 && lock == pass1) ||
                                    (phoneNumber == phone2 && lock == pass2) ||
                                    (phoneNumber == phone3 && lock == pass3) ||
                                    (phoneNumber == phone4 && lock == pass4) ||
                                    (phoneNumber == phone5 && lock == pass5)) {
                                  if (phoneNumber == phone1) {
                                    prefs.setString(PrefsKeys.kName, name1);
                                    prefs.setString(
                                        PrefsKeys.kPhone, phoneNumber);
                                  } else if (phoneNumber == phone2) {
                                    prefs.setString(PrefsKeys.kName, name2);
                                    prefs.setString(
                                        PrefsKeys.kPhone, phoneNumber);
                                  } else if (phoneNumber == phone3) {
                                    prefs.setString(PrefsKeys.kName, name3);
                                    prefs.setString(
                                        PrefsKeys.kPhone, phoneNumber);
                                  } else if (phoneNumber == phone4) {
                                    prefs.setString(PrefsKeys.kName, name4);
                                    prefs.setString(
                                        PrefsKeys.kPhone, phoneNumber);
                                  } else if (phoneNumber == phone5) {
                                    prefs.setString(PrefsKeys.kName, name5);
                                    prefs.setString(
                                        PrefsKeys.kPhone, phoneNumber);
                                  }
                                  prefs.setBool(PrefsKeys.kIsLoggedIn, true);
                                  prefs.setBool(PrefsKeys.kAdmin, true);
                                  prefs.setString(PrefsKeys.kFirebaseID, '0');
                                  await GetInstance.auth.signInAnonymously();
                                  await GetInstance.msg
                                      .subscribeToTopic('notify');
                                  await GetInstance.msg
                                      .subscribeToTopic('newUsers');
                                  await GetInstance.msg.subscribeToTopic('0');
                                  if (context.mounted) {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      HomeLayout.id,
                                    );
                                    AuthCubit.get(context)
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
                                        style: TextStyle(
                                            color: AppTheme.whiteTextColor),
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
                                AuthCubit.get(context).buttonIsLoading(false);
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

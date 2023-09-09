import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/cubit.dart';
import '../components/constants.dart';
import '../components/theme.dart';
import '../components/widgets/back_button.dart';
import '../components/widgets/default_button.dart';
import '../components/widgets/text_form_field.dart';
import '../layouts/login Layout/login_page.dart';

void profileDialog(
  BuildContext context,
  GlobalKey<FormState> formKey,
  String name,
  String phone,
  bool manager,
) {
  showDialog(
    context: context,
    builder: (context) {
      TextEditingController nameController = TextEditingController();
      TextEditingController phoneController = TextEditingController();

      nameController.text = name;
      phoneController.text = phone;

      return AlertDialog(
        contentPadding:
            const EdgeInsets.only(top: 24, right: 24, left: 24, bottom: 16),
        titlePadding: EdgeInsets.zero,
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                myTextFormField(
                  textStyleColor: AppCubit.get(context).iconAndTextColor,
                  color: AppCubit.get(context).iconAndTextColor,
                  controller: nameController,
                  type: TextInputType.name,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'your name is required';
                    }
                    return null;
                  },
                  label: 'Your Name',
                  prefix: Icons.title,
                  context: context,
                  isEnabled: !manager,
                ),
                const SizedBox(
                  height: 24,
                ),
                myTextFormField(
                    textStyleColor: AppCubit.get(context).iconAndTextColor,
                    color: AppCubit.get(context).iconAndTextColor,
                    limit: 11,
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'your phone is required';
                      }
                      if (!value.startsWith('01') || value.length != 11) {
                        return 'enter a valid phone number';
                      }
                      return null;
                    },
                    label: 'Your Phone',
                    prefix: Icons.phone,
                    context: context,
                    isEnabled: !manager),
                manager
                    ? const SizedBox()
                    : Column(
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          defaultButton(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString(
                                  yourName,
                                  nameController.text,
                                );
                                prefs.setString(
                                  yourPhone,
                                  phoneController.text,
                                );
                                FirebaseFirestore.instance
                                    .collection('App Users')
                                    .doc(prefs.getString(id))
                                    .set(
                                        {
                                      'ID': prefs.getString(id),
                                      'Name': nameController.text,
                                      'Phone Number': phoneController.text,
                                    },
                                        SetOptions(
                                          merge: true,
                                        ));
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      backgroundColor: racketFirstColor,
                                      content: Text(
                                        'Updated Successfully',
                                        style: TextStyle(color: textColor),
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            text: "Update",
                            color: racketFirstColor,
                          ),
                        ],
                      ),
                const SizedBox(
                  height: 12,
                ),
                defaultButton(
                  color: bookedColor,
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.setBool(isLoggedIn, false);
                    FirebaseAuth.instance.signOut();
                    if (context.mounted) {
                      AppCubit.get(context).changeBottomNavIndex(0);
                      AppCubit.get(context).loginPageState(0);
                      FirebaseMessaging.instance.unsubscribeFromTopic('notify');
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                        context,
                        LoginPage.id,
                      );
                    }
                  },
                  text: 'Log Out',
                ),
                const SizedBox(
                  height: 12,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyBackButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

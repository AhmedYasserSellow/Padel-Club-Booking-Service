import 'package:booking/core/theme/logic/theme_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../logic/home_cubit.dart';
import '../../../core/constants/constants.dart';
import '../../../core/theme/theme.dart';
import '../../../core/widgets/back_button.dart';
import '../../../core/widgets/default_button.dart';
import '../../../core/widgets/text_form_field.dart';

void profileDialog(
  BuildContext context,
  String name,
  String phone,
  bool manager,
) {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                  textStyleColor: ThemeCubit.get(context).iconAndTextColor,
                  color: ThemeCubit.get(context).iconAndTextColor,
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
                ),
                const SizedBox(
                  height: 24,
                ),
                myTextFormField(
                  textStyleColor: ThemeCubit.get(context).iconAndTextColor,
                  color: ThemeCubit.get(context).iconAndTextColor,
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
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    defaultButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          final prefs = await SharedPreferences.getInstance();
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
                            HomeCubit.get(context).changeName();
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 1500),
                                backgroundColor: racketFirstColor,
                                content: Text(
                                  'Updated Successfully',
                                  style: TextStyle(color: whiteTextColor),
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

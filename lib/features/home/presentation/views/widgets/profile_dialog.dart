import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/core/widgets/back_button.dart';
import 'package:padel_club/core/widgets/default_button.dart';
import 'package:padel_club/core/widgets/text_form_field.dart';
import 'package:padel_club/features/home/presentation/view_models/home_cubit/home_cubit.dart';

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
      HomeCubit cubit = HomeCubit.get(context);

      cubit.profileNameController.text = name;
      cubit.profilePhoneController.text = phone;

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
                  textStyleColor: HomeCubit.get(context).iconAndTextColor,
                  color: HomeCubit.get(context).iconAndTextColor,
                  controller: cubit.profileNameController,
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
                  textStyleColor: HomeCubit.get(context).iconAndTextColor,
                  color: HomeCubit.get(context).iconAndTextColor,
                  limit: 11,
                  controller: cubit.profilePhoneController,
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
                          cubit.updateProfile(context);
                        }
                      },
                      text: "Update",
                      color: AppTheme.racketFirstColor,
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

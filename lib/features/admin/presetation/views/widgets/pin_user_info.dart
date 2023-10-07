import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/core/widgets/text_form_field.dart';
import 'package:padel_club/features/admin/presetation/view_model/pin_cubit/pin_cubit.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final PinCubit cubit = PinCubit.get(context);
    return Column(
      children: [
        Text(
          'User Info',
          style: TextStyle(color: AppTheme.whiteTextColor),
        ),
        const SizedBox(
          height: 12,
        ),
        myTextFormField(
          controller: cubit.name,
          type: TextInputType.name,
          validate: (String? value) {
            if (value!.isEmpty) {
              return 'name is required';
            }
            return null;
          },
          label: 'Name',
          prefix: Icons.title,
          context: context,
          color: AppTheme.whiteTextColor,
          textStyleColor: AppTheme.whiteTextColor,
          labelColor: AppTheme.whiteTextColor,
          focusColor: AppTheme.whiteTextColor,
        ),
        const SizedBox(
          height: 12,
        ),
        myTextFormField(
          limit: 11,
          controller: cubit.phone,
          type: TextInputType.phone,
          validate: (String? value) {
            if (value!.isEmpty) {
              return 'phone number is required';
            }
            if (!value.startsWith('01') || value.length != 11) {
              return 'enter a valid phone number';
            }
            return null;
          },
          label: 'Phone Number',
          prefix: Icons.phone,
          context: context,
          color: AppTheme.whiteTextColor,
          textStyleColor: AppTheme.whiteTextColor,
          labelColor: AppTheme.whiteTextColor,
          focusColor: AppTheme.whiteTextColor,
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

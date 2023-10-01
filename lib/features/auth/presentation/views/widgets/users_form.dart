import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/core/widgets/default_button.dart';
import 'package:padel_club/core/widgets/text_form_field.dart';
import 'package:padel_club/features/auth/presentation/view_models/auth_cubit/auth_cubit.dart';

class UserForm extends StatelessWidget {
  const UserForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Form(
          key: cubit.userFormKey,
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const BackButtonIcon(),
                    color: AppTheme.whiteTextColor,
                    onPressed: () => AuthCubit.get(context).backToSelectRole(),
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
                controller: cubit.userName,
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
                controller: cubit.userPhone,
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
                  cubit.logInForUser(context);
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

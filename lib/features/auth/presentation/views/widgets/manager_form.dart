import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/core/widgets/default_button.dart';
import 'package:padel_club/core/widgets/text_form_field.dart';
import 'package:padel_club/features/auth/presentation/view_models/auth_cubit/auth_cubit.dart';

class ManagersForm extends StatelessWidget {
  const ManagersForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return StreamBuilder(
            stream: GetInstance.store.collection('Users').snapshots(),
            builder: (context, snapshot) {
              return Form(
                key: cubit.adminFormKey,
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
                      controller: cubit.adminPhone,
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
                      controller: cubit.adminPassword,
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
                          await cubit.logInForAdmin(context, snapshot);
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

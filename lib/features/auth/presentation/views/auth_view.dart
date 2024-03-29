import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/features/auth/presentation/view_models/auth_cubit/auth_cubit.dart';
import 'package:padel_club/features/auth/presentation/views/widgets/choose_your_role.dart';
import 'package:padel_club/features/auth/presentation/views/widgets/manager_form.dart';
import 'package:padel_club/features/auth/presentation/views/widgets/users_form.dart';
import 'package:padel_club/features/home/presentation/view_models/home_cubit/home_cubit.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});
  static String id = 'AuthLayout';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        HomeCubit.get(context)
            .setStatusBarUI(Brightness.light, Brightness.dark);
        return BlocProvider(
          create: (context) => AuthCubit(),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    AppTheme.racketFirstColor,
                    AppTheme.racketSecondColor,
                  ]),
                ),
                child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  backgroundColor: Colors.transparent,
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 20,
                      ),
                      child: SafeArea(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            Center(
                              child: Image.asset(
                                Assets.kLogoDark,
                                width:
                                    MediaQuery.of(context).size.width * 2 / 3,
                              ),
                            ),
                            const SizedBox(
                              height: 48,
                            ),
                            if (AuthCubit.get(context).loginFormState == 0)
                              const ChooseRole()
                            else if (AuthCubit.get(context).loginFormState == 1)
                              const UserForm()
                            else
                              const ManagersForm(),
                            const SizedBox(
                              height: 48,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

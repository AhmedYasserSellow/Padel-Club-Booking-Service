import 'package:booking/bloc/states.dart';
import 'package:booking/components/theme.dart';
import 'package:booking/layouts/auth/choose_your_role.dart';
import 'package:booking/layouts/auth/users_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/cubit.dart';
import 'manager_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [racketFirstColor, racketSecondColor]),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
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
                          'assets/logodark.png',
                          width: MediaQuery.of(context).size.width * 2 / 3,
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      AppCubit.get(context).loginFormState == 0
                          ? const ChooseRole()
                          : AppCubit.get(context).loginFormState == 1
                              ? const UserForm()
                              : const ManagersForm(),
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
    );
  }
}

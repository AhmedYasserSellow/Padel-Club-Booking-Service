import 'package:booking/layouts/auth/widgets/choose_your_role.dart';
import 'package:booking/layouts/auth/widgets/manager_form.dart';
import 'package:booking/layouts/auth/widgets/users_form.dart';
import 'package:booking/logic/states.dart';
import 'package:booking/components/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static String id = 'LoginPage';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
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
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              toolbarHeight: 0,
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

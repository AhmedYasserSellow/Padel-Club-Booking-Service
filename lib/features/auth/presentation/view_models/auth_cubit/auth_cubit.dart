import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  int loginFormState = 0;
  bool isLoading = false;
  bool isHidden = true;

  GlobalKey<FormState> adminFormKey = GlobalKey<FormState>();
  TextEditingController adminPhone = TextEditingController();
  TextEditingController adminPassword = TextEditingController();

  GlobalKey<FormState> userFormKey = GlobalKey<FormState>();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userName = TextEditingController();

  static AuthCubit get(context) => BlocProvider.of(context);
  void loginPageState(index) {
    loginFormState = index;
    emit(LoginPageUpdate());
  }

  void buttonIsLoading(bool buttonIsLoading) {
    isLoading = buttonIsLoading;
    emit(ButtonLoadingState());
  }

  void passwordState() {
    isHidden = !isHidden;
    emit(PasswordState());
  }

  Future logInForAdmin(BuildContext context, AsyncSnapshot snapshot) async {
    GetInstance.authRepoImpl
        .logInForAdmin(context, snapshot, adminPhone, adminPassword);
  }

  Future logInForUser(BuildContext context) async {
    GetInstance.authRepoImpl.logInForUser(context);
  }
}

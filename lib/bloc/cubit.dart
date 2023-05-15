import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int navIndex = 0;
  int navIndexForDB = 0;
  int dialogTabIndex = 1;
  int monthDB = 1;
  int dayDB = 1;
  int indexDB = 0;
  DateTime focusedDay = DateTime.now();
  DateTime firstDay = DateTime.now();

  Brightness brightness = Brightness.light;

  Color iconAndTextColor = Colors.black;
  IconData modeIcon = Icons.light_mode;
  bool isLightMode = true;
  int loginFormState = 0;
  bool firstLogin = true;
  bool isHidden = true;

  void passwordState() {
    isHidden = !isHidden;
    emit(PasswordState());
  }

  void loginPageState(index) {
    loginFormState = index;
    emit(LoginPageUpdate());
  }

  void changeTheme() {
    if (isLightMode) {
      isLightMode = !isLightMode;

      brightness = Brightness.dark;
      iconAndTextColor = Colors.white;
      modeIcon = Icons.dark_mode;
    } else {
      isLightMode = !isLightMode;
      brightness = Brightness.light;
      iconAndTextColor = Colors.black;
      modeIcon = Icons.light_mode;
    }
    emit(ChangeTheme());
  }

  void changeBottomNavIndex(int index) {
    navIndex = index;
    emit(ChangeBottomNavIndex());
  }

  void changeBottomNavIndexForDB(int index) {
    navIndexForDB = index;
    emit(ChangeBottomNavIndexForDB());
  }

  void progressCalculator() {
    emit(ProgressCalculator());
  }
}

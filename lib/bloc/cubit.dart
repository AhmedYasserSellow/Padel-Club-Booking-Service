import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/theme.dart';
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
  DateTime today = DateTime.now();

  Brightness brightness = Brightness.light;

  Color iconAndTextColor = Colors.black;
  IconData modeIcon = Icons.light_mode;
  bool isLightMode = true;
  int loginFormState = 0;
  bool firstLogin = true;
  bool isHidden = true;

//Get Theme data on creating app
  Future<bool> getTheme() async {
    bool? getLightMode;
    final prefs = await SharedPreferences.getInstance();
    if (SchedulerBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.light) {
      getLightMode = true;
    } else {
      getLightMode = false;
    }

    bool isLightMode;
    if (prefs.getBool('Mode') == null) {
      prefs.setBool('Mode', getLightMode);
    }
    isLightMode = prefs.getBool('Mode')!;
    return isLightMode;
  }

  void getAppTheme() async {
    isLightMode = await getTheme();
    if (isLightMode) {
      iconAndTextColor = textAndIconLightModeColor;
      modeIcon = Icons.light_mode;
    } else {
      iconAndTextColor = textAndIconDarkModeColor;
      modeIcon = Icons.dark_mode;
    }
    emit(GetTheme());
  }

// Toogle obscure text for password
  void passwordState() {
    isHidden = !isHidden;
    emit(PasswordState());
  }

// Change Role
  void loginPageState(index) {
    loginFormState = index;
    emit(LoginPageUpdate());
  }

//Change Theme
  void changeTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (isLightMode) {
      isLightMode = !isLightMode;
      prefs.setBool('Mode', isLightMode);
      brightness = Brightness.dark;
      iconAndTextColor = textAndIconDarkModeColor;
      modeIcon = Icons.dark_mode;
    } else {
      isLightMode = !isLightMode;
      prefs.setBool('Mode', isLightMode);
      brightness = Brightness.light;
      iconAndTextColor = textAndIconLightModeColor;
      modeIcon = Icons.light_mode;
    }
    emit(ChangeTheme());
  }

//Navigate in Bottom Nav bar for home layout
  void navigateToMainPages(BuildContext context, int index) {
    navIndex = index;
    Navigator.pop(context);
    emit(NavigateToAnotherMainPage());
  }

//Navigate in Bottom Nav bar for dashboard layout
  void changeBottomNavIndexForDB(int index) {
    navIndexForDB = index;
    emit(ChangeBottomNavIndexForDB());
  }

//Progress Calculator for adding year to database
  void progressCalculator() {
    emit(ProgressCalculator());
  }

  void changeName() async {
    emit(NameChanged());
  }
}

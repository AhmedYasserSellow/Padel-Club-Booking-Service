import 'package:booking/core/constants/constants.dart';
import 'package:booking/layouts/auth/auth_screen.dart';
import 'package:booking/layouts/on%20boarding/widgets/screens_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/theme/theme.dart';
import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int mainPagesIndex = 0;
  int dashboardPagesIndex = 0;
  int dialogTabIndex = 1;
  int monthDB = 1;
  int dayDB = 1;
  int indexDB = 0;
  int onBoardingIndex = 0;
  DateTime focusedDay = DateTime.now();
  DateTime today = DateTime.now();

  Brightness brightness = Brightness.light;

  Color iconAndTextColor = Colors.black;
  IconData modeIcon = Icons.light_mode;
  bool isLightMode = true;
  int loginFormState = 0;
  bool firstLogin = true;
  bool isHidden = true;
  bool isExpanded = false;
  bool isLoading = false;

// Get Theme
  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();

    bool isLightMode;
    if (prefs.getBool('Mode') == null) {
      prefs.setBool('Mode', true);
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

//Navigate in Drawer for home layout
  void navigateToMainPages(BuildContext context, int index) {
    mainPagesIndex = index;
    Navigator.pop(context);
    emit(NavigateToAnotherMainPage());
  }

//Navigate in Drawer for dashboard layout
  void navigateToDashboardPages(BuildContext context, int index) {
    dashboardPagesIndex = index;
    Navigator.pop(context);
    emit(ChangeBottomNavIndexForDB());
  }

//Progress Calculator for adding year to database
  void progressCalculator() {
    emit(ProgressCalculator());
  }

//Add Progress indicator to button

  void buttonIsLoading(bool buttonIsLoading) {
    isLoading = buttonIsLoading;
    emit(ButtonLoadingState());
  }

//Profile Name Changer
  void changeName() async {
    emit(NameChanged());
  }

  //On boarding index changer
  void changeOnBoardingScreenIndex(BuildContext context, int index) async {
    onBoardingIndex = index;

    final prefs = await SharedPreferences.getInstance();
    if (context.mounted) {
      AppCubit.get(context).onBoardingIndex += 1;
      if (AppCubit.get(context).onBoardingIndex ==
          onBoardingInfoSection.length) {
        prefs.setBool(isOnBoarding, false);
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, AuthScreen.id);
        }
      } else {
        emit(OnBoardingPageChanged());
      }
    }
  }
}

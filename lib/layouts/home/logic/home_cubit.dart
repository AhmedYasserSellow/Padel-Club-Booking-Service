import 'package:booking/core/utilities/constants/constants.dart';
import 'package:booking/core/utilities/services/notifications.dart';
import 'package:booking/core/utilities/theme/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(AppIntialState());

  static HomeCubit get(context) => BlocProvider.of(context);
  int mainPagesIndex = 0;
  bool isExpanded = false;
  DateTime focusedDay = DateTime.now();
  DateTime today = DateTime.now();

  bool manager = false;
  String name = '';
  String phone = '';
  String firebaseID = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Future loadState() async {
    enableFirebaseMessaging();
    final prefs = await SharedPreferences.getInstance();
    manager = prefs.getBool(dev)!;
    name = prefs.getString(yourName)!;
    phone = prefs.getString(yourPhone)!;
    firebaseID = prefs.getString(id)!;
  }

  enableFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationService().showNotification(
        title: message.notification!.title,
        body: message.notification!.body,
      );
    });
  }

//Navigate in Drawer for home layout
  void navigateToMainPages(BuildContext context, int index,
      {bool isDrawer = true}) {
    mainPagesIndex = index;
    if (isDrawer) {
      scaffoldKey.currentState!.closeDrawer();
    } else {
      Navigator.pop(context);
    }

    emit(NavigateToAnotherMainPage());
  }

//Change Expansion
  void pagesExpnasionChanger(bool expanded) {
    isExpanded = expanded;
    emit(ChangeExpansion());
  }

//Change selected day

  void changeSelectedDay(DateTime day) {
    focusedDay = day;
    emit(DayChanged());
  }

//Profile Name Changer
  void changeName() async {
    emit(NameChanged());
  }

  Brightness brightness = Brightness.light;
  Color iconAndTextColor = Colors.black;
  IconData modeIcon = Icons.light_mode;
  bool isLightMode = true;
  int loginFormState = 0;
  bool firstLogin = true;

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
}

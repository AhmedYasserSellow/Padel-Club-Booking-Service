import 'package:booking/core/constants/constants.dart';
import 'package:booking/core/services/notifications.dart';
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
  void navigateToMainPages(BuildContext context, int index) {
    mainPagesIndex = index;
    Navigator.pop(context);
    emit(NavigateToAnotherMainPage());
  }

//Profile Name Changer
  void changeName() async {
    emit(NameChanged());
  }
}

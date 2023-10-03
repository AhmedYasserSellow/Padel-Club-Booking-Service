import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/services/notifications.dart';
import 'package:padel_club/features/admin/data/repos/admin_repo_impl.dart';
import 'package:padel_club/features/auth/data/repos/auth_repo_impl.dart';
import 'package:padel_club/features/booking/data/repos/booking_repo_impl.dart';
import 'package:padel_club/features/chat/data/repos/chat_repo_impl.dart';
import 'package:padel_club/features/home/data/repos/home_repo_ipml.dart';
import 'package:padel_club/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GetInstance {
  static final getIt = GetIt.instance;
  static setupFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static registerInstances() {
    getIt.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance(),
    );
    getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
    getIt.registerSingleton<FirebaseMessaging>(FirebaseMessaging.instance);
    getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
    getIt.registerSingleton<AdminRepoImpl>(AdminRepoImpl());
    getIt.registerSingleton<AuthRepoImpl>(AuthRepoImpl());
    getIt.registerSingleton<HomeRepoImpl>(HomeRepoImpl());
    getIt.registerSingleton<BookingRepoImpl>(BookingRepoImpl());
    getIt.registerSingleton<ChatRepoImpl>(ChatRepoImpl());
  }

  static intializeNotofications() async {
    final prefs = await GetInstance.prefs;
    bool isShowed = prefs.getBool(PrefsKeys.kIsPremessionShowed) ?? false;
    if (isShowed == false) {
      await NotificationService.getPermssion();
      prefs.setBool(PrefsKeys.kIsPremessionShowed, true);
    }

    NotificationService.initNotification();
  }

  static final auth = getIt.get<FirebaseAuth>();
  static final msg = getIt.get<FirebaseMessaging>();
  static final store = getIt.get<FirebaseFirestore>();
  static final prefs = getIt.getAsync<SharedPreferences>();
  static final adminRepoImpl = getIt.get<AdminRepoImpl>();
  static final authRepoImpl = getIt.get<AuthRepoImpl>();
  static final homeRepoImpl = getIt.get<HomeRepoImpl>();
  static final bookingRepoImpl = getIt.get<BookingRepoImpl>();
  static final chatRepoImpl = getIt.get<ChatRepoImpl>();
}

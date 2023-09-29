import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GetInstance {
  static final getIt = GetIt.instance;
  static setup() {
    getIt.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance(),
    );
    getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
    getIt.registerSingleton<FirebaseMessaging>(FirebaseMessaging.instance);
    getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  }

  static final auth = getIt.get<FirebaseAuth>();
  static final msg = getIt.get<FirebaseMessaging>();
  static final store = getIt.get<FirebaseFirestore>();
  static final prefs = getIt.getAsync<SharedPreferences>();
}

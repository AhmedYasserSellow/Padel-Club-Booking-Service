// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA590O7_Z2vShrqyrDmt6ixLXJyk4R-oEE',
    appId: '1:27119695809:web:6b02e622c2e772bb48a140',
    messagingSenderId: '27119695809',
    projectId: 'padel-club-2023',
    authDomain: 'padel-club-2023.firebaseapp.com',
    storageBucket: 'padel-club-2023.appspot.com',
    measurementId: 'G-GCC9LDDKD1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBC95HtDoW2XctVDwD5pnB_i8jnZw347TQ',
    appId: '1:27119695809:android:8c62f54a4650e4c548a140',
    messagingSenderId: '27119695809',
    projectId: 'padel-club-2023',
    storageBucket: 'padel-club-2023.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAbF1YkrQQfPTZKexKG7GYdW6H_ywECAxo',
    appId: '1:27119695809:ios:7a7c566168a5ffb048a140',
    messagingSenderId: '27119695809',
    projectId: 'padel-club-2023',
    storageBucket: 'padel-club-2023.appspot.com',
    iosClientId: '27119695809-jj8ljb1j8uce54pcr2g2rem1t9kv2ip1.apps.googleusercontent.com',
    iosBundleId: 'com.example.padelClub',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAbF1YkrQQfPTZKexKG7GYdW6H_ywECAxo',
    appId: '1:27119695809:ios:7a7c566168a5ffb048a140',
    messagingSenderId: '27119695809',
    projectId: 'padel-club-2023',
    storageBucket: 'padel-club-2023.appspot.com',
    iosClientId: '27119695809-jj8ljb1j8uce54pcr2g2rem1t9kv2ip1.apps.googleusercontent.com',
    iosBundleId: 'com.example.padelClub',
  );
}
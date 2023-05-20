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
    apiKey: 'AIzaSyBEHFYuFj4PxDL8ziDUUSUUvnnCtWQEziQ',
    appId: '1:612967960403:web:0ab57c010623eada205ba6',
    messagingSenderId: '612967960403',
    projectId: 'bookingtest-a54a5',
    authDomain: 'bookingtest-a54a5.firebaseapp.com',
    storageBucket: 'bookingtest-a54a5.appspot.com',
    measurementId: 'G-R50NWCEWH7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDiKr6ZNHeCYWgWJwTensnvO2a98stbVaU',
    appId: '1:612967960403:android:94933a6e4a8a8cb0205ba6',
    messagingSenderId: '612967960403',
    projectId: 'bookingtest-a54a5',
    storageBucket: 'bookingtest-a54a5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCereXV56NWr0WIINHFexiFmrLB8d32ptY',
    appId: '1:612967960403:ios:0ff2c150d04d7f85205ba6',
    messagingSenderId: '612967960403',
    projectId: 'bookingtest-a54a5',
    storageBucket: 'bookingtest-a54a5.appspot.com',
    iosClientId: '612967960403-1bovgkq0k3aabgcm97ifq30m05vs0ckp.apps.googleusercontent.com',
    iosBundleId: 'com.example.padelClub',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCereXV56NWr0WIINHFexiFmrLB8d32ptY',
    appId: '1:612967960403:ios:0ff2c150d04d7f85205ba6',
    messagingSenderId: '612967960403',
    projectId: 'bookingtest-a54a5',
    storageBucket: 'bookingtest-a54a5.appspot.com',
    iosClientId: '612967960403-1bovgkq0k3aabgcm97ifq30m05vs0ckp.apps.googleusercontent.com',
    iosBundleId: 'com.example.padelClub',
  );
}

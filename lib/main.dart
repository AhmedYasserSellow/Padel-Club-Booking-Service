import 'package:booking/core/constants/constants.dart';
import 'package:booking/core/services/notifications.dart';
import 'package:booking/core/theme/dark_theme.dart';
import 'package:booking/core/theme/light_theme.dart';
import 'package:booking/core/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'logic/cubit.dart';
import 'logic/states.dart';

import 'firebase_options.dart';

import 'layouts/splash/splash_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final prefs = await SharedPreferences.getInstance();
  bool isShowed = prefs.getBool(isPremessionShowed) ?? false;
  if (isShowed == false) {
    await getPermssion();
    prefs.setBool(isPremessionShowed, true);
  }

  NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return AppCubit()..getAppTheme();
      },
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Padel Club',
            theme: AppCubit.get(context).isLightMode
                //Light Theme
                ? lightTheme
                //Dark Theme
                : darkTheme,
            debugShowCheckedModeBanner: false,
            routes: appRoutes,
            initialRoute: SplashLayout.id,
          );
        },
      ),
    );
  }
}

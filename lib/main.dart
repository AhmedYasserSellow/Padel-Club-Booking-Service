import 'package:booking/components/constants.dart';
import 'package:booking/components/notifications.dart';
import 'package:booking/components/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'logic/cubit.dart';
import 'logic/states.dart';

import 'firebase_options.dart';

import 'layouts/home/screens/splash screen/splash_screen.dart';

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
            initialRoute: Splash.id,
          );
        },
      ),
    );
  }
}

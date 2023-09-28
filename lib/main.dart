import 'package:booking/core/utilities/constants/constants.dart';
import 'package:booking/core/utilities/routes/app_routes.dart';
import 'package:booking/core/utilities/services/notifications.dart';
import 'package:booking/core/utilities/theme/dark_theme.dart';
import 'package:booking/core/utilities/theme/light_theme.dart';
import 'package:booking/core/utilities/theme/logic/theme_cubit.dart';
import 'package:booking/layouts/home/logic/home_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'layouts/splash/splash_layout.dart';
import 'firebase_options.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ThemeCubit()..getAppTheme(),
        ),
        BlocProvider(
          create: (BuildContext context) => HomeCubit()..loadState(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Padel Club',
            theme: ThemeCubit.get(context).isLightMode
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

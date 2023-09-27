import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:booking/components/constants/constants.dart';
import 'package:booking/layouts/home/home_layout.dart';
import 'package:booking/layouts/auth/login_page.dart';
import 'package:booking/layouts/on%20boarding/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../logic/cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String id = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loggedIn = false;
  bool onBoarding = true;
  @override
  void initState() {
    super.initState();
    loadState();
  }

  void loadState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      loggedIn = prefs.getBool(isLoggedIn) ?? false;
      onBoarding = prefs.getBool(isOnBoarding) ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset(
        AppCubit.get(context).isLightMode
            ? 'assets/logo.png'
            : 'assets/logodark.png',
      ),
      splashIconSize: MediaQuery.of(context).size.width * 3 / 4,
      duration: 1500,
      nextScreen: onBoarding
          ? const OnBoardingScreen()
          : loggedIn
              ? const HomeScreen()
              : const AuthScreen(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:booking/core/utilities/constants/constants.dart';
import 'package:booking/layouts/home/home_layout.dart';
import 'package:booking/layouts/auth/auth_layout.dart';
import 'package:booking/layouts/on%20boarding/on_boarding_layout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:booking/layouts/home/logic/home_cubit.dart';

class SplashLayout extends StatefulWidget {
  const SplashLayout({super.key});
  static String id = 'SplashLayout';

  @override
  State<SplashLayout> createState() => _SplashLayoutState();
}

class _SplashLayoutState extends State<SplashLayout> {
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
        HomeCubit.get(context).isLightMode
            ? Assets.kLogoLight
            : Assets.kLogoDark,
      ),
      splashIconSize: MediaQuery.of(context).size.width * 3 / 4,
      duration: 1500,
      nextScreen: onBoarding
          ? const OnBoardingLayout()
          : loggedIn
              ? const HomeLayout()
              : const AuthLayout(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}

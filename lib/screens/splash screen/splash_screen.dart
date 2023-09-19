import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:booking/components/constants.dart';
import 'package:booking/layouts/home_layout.dart';
import 'package:booking/layouts/login%20Layout/login_page.dart';
import 'package:booking/screens/on%20boarding%20screen/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/cubit.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  static String id = 'SplashPage';

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool loggedIn = false;
  bool onBoarding = false;
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
    return ResponsiveSizer(builder: (context, or, screenType) {
      return AnimatedSplashScreen(
        splash: Image.asset(
          AppCubit.get(context).isLightMode
              ? 'assets/logo.png'
              : 'assets/logodark.png',
        ),
        splashIconSize: MediaQuery.of(context).size.width * 3 / 4,
        duration: 1500,
        nextScreen: onBoarding
            ? const OnBoardingPage()
            : loggedIn
                ? const HomePage()
                : const LoginPage(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      );
    });
  }
}

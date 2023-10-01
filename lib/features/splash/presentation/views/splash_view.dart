import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/features/auth/presentation/views/auth_view.dart';
import 'package:padel_club/features/home/presentation/view_models/home_cubit/home_cubit.dart';
import 'package:padel_club/features/home/presentation/views/home_view.dart';
import 'package:padel_club/features/on%20boarding/presentation/views/on_boarding_view.dart';
import 'package:padel_club/features/splash/presentation/view_models/splash_cubit/splash_cubit.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});
  static String id = 'SplashLayout';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SplashCubit(),
        child: Builder(builder: (context) {
          return FutureBuilder(
            future: SplashCubit.get(context).loadState(),
            builder: (context, snapshot) {
              SplashCubit cubit = SplashCubit.get(context);
              return AnimatedSplashScreen(
                splash: Image.asset(
                  HomeCubit.get(context).isLightMode
                      ? Assets.kLogoLight
                      : Assets.kLogoDark,
                ),
                splashIconSize: MediaQuery.of(context).size.width * 3 / 4,
                duration: 1500,
                nextScreen: cubit.onBoarding
                    ? const OnBoardingView()
                    : cubit.loggedIn
                        ? const HomeView()
                        : const AuthView(),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              );
            },
          );
        }));
  }
}

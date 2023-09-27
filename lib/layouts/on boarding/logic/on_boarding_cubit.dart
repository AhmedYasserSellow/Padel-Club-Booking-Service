import 'package:booking/core/constants/constants.dart';
import 'package:booking/core/routes/app_routes.dart';
import 'package:booking/layouts/auth/auth_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());

  static OnBoardingCubit get(context) => BlocProvider.of(context);
  int onBoardingIndex = 0;
  void changeOnBoardingScreenIndex(BuildContext context, int index) async {
    onBoardingIndex = index;

    final prefs = await SharedPreferences.getInstance();
    if (context.mounted) {
      onBoardingIndex += 1;
      if (onBoardingIndex == onBoardingPages.length) {
        prefs.setBool(isOnBoarding, false);
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, AuthLayout.id);
        }
      } else {
        emit(OnBoardingPageChanged());
      }
    }
  }
}

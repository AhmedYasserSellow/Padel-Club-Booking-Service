import 'package:booking/core/utilities/constants/constants.dart';
import 'package:booking/core/utilities/routes/app_routes.dart';
import 'package:booking/core/utilities/services/service_locator.dart';
import 'package:booking/layouts/auth/auth_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());

  static OnBoardingCubit get(context) => BlocProvider.of(context);
  int onBoardingIndex = 0;
  void changeOnBoardingScreenIndex(BuildContext context, int index) async {
    onBoardingIndex = index;

    final prefs = await GetInstance.prefs;
    if (context.mounted) {
      onBoardingIndex += 1;
      if (onBoardingIndex == onBoardingPages.length) {
        prefs.setBool(PrefsKeys.kIsOnBoarding, false);
        if (context.mounted) {
          Navigator.pushReplacementNamed(context, AuthLayout.id);
        }
      } else {
        emit(OnBoardingPageChanged());
      }
    }
  }
}

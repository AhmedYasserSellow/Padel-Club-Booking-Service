import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/features/auth/presentation/views/auth_view.dart';
import 'package:padel_club/features/on%20boarding/presentation/views/widgets/on_boarding_info_item.dart';

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
          Navigator.pushReplacementNamed(context, AuthView.id);
        }
      } else {
        emit(OnBoardingPageChanged());
      }
    }
  }
}

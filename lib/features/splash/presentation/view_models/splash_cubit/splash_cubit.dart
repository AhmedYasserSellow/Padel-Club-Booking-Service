import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  static SplashCubit get(context) => BlocProvider.of(context);

  bool loggedIn = false;
  bool onBoarding = true;

  Future loadState() async {
    final prefs = await GetInstance.prefs;
    loggedIn = prefs.getBool(PrefsKeys.kIsLoggedIn) ?? false;
    onBoarding = prefs.getBool(PrefsKeys.kIsOnBoarding) ?? true;
  }
}

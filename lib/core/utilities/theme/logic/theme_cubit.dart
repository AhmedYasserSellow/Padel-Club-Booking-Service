import 'package:booking/core/utilities/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  static ThemeCubit get(context) => BlocProvider.of(context);

  Brightness brightness = Brightness.light;
  Color iconAndTextColor = Colors.black;
  IconData modeIcon = Icons.light_mode;
  bool isLightMode = true;
  int loginFormState = 0;
  bool firstLogin = true;

// Get Theme
  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();

    bool isLightMode;
    if (prefs.getBool('Mode') == null) {
      prefs.setBool('Mode', true);
    }
    isLightMode = prefs.getBool('Mode')!;
    return isLightMode;
  }

  void getAppTheme() async {
    isLightMode = await getTheme();
    if (isLightMode) {
      iconAndTextColor = textAndIconLightModeColor;
      modeIcon = Icons.light_mode;
    } else {
      iconAndTextColor = textAndIconDarkModeColor;
      modeIcon = Icons.dark_mode;
    }
    emit(GetTheme());
  }

//Change Theme
  void changeTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (isLightMode) {
      isLightMode = !isLightMode;
      prefs.setBool('Mode', isLightMode);
      brightness = Brightness.dark;
      iconAndTextColor = textAndIconDarkModeColor;
      modeIcon = Icons.dark_mode;
    } else {
      isLightMode = !isLightMode;
      prefs.setBool('Mode', isLightMode);
      brightness = Brightness.light;
      iconAndTextColor = textAndIconLightModeColor;
      modeIcon = Icons.light_mode;
    }
    emit(ChangeTheme());
  }
}

import 'package:booking/core/utilities/theme/logic/theme_cubit.dart';
import 'package:booking/layouts/home/screens/drawer%20screen/widgets/drawer_item.dart';
import 'package:flutter/material.dart';

class ThemeChangerButton extends StatelessWidget {
  const ThemeChangerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerItem(
      isSelected: false,
      onTap: () {
        ThemeCubit.get(context).changeTheme();
      },
      text: Theme.of(context).brightness == Brightness.dark
          ? 'Dark Mode'
          : 'Light Mode',
      icon: ThemeCubit.get(context).modeIcon,
    );
  }
}

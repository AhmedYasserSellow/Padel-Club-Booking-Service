import 'package:booking/logic/cubit.dart';
import 'package:booking/layouts/home/drawer/widgets/drawer_item.dart';
import 'package:flutter/material.dart';

class ThemeChangerButton extends StatelessWidget {
  const ThemeChangerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerItem(
      isSelected: false,
      onTap: () {
        AppCubit.get(context).changeTheme();
      },
      text: Theme.of(context).brightness == Brightness.dark
          ? 'Dark Mode'
          : 'Light Mode',
      icon: AppCubit.get(context).modeIcon,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:padel_club/features/home/presentation/view_models/home_cubit/home_cubit.dart';
import 'package:padel_club/features/home/presentation/views/widgets/drawer_item.dart';

class ThemeChangerButton extends StatelessWidget {
  const ThemeChangerButton({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerItem(
      isSelected: false,
      onTap: () {
        HomeCubit.get(context).changeTheme();
      },
      text: Theme.of(context).brightness == Brightness.dark
          ? 'Dark Mode'
          : 'Light Mode',
      icon: HomeCubit.get(context).modeIcon,
    );
  }
}

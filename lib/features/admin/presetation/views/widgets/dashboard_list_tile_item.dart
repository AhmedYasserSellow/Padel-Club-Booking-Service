import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';

class DashboardListTileItem extends StatelessWidget {
  const DashboardListTileItem({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });
  final String text;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selectedColor: const Color(0xff000000),
      titleTextStyle: TextStyle(
        color: AppTheme.whiteTextColor,
      ),
      leading: Icon(
        icon,
        color: AppTheme.whiteTextColor,
      ),
      title: Text(
        text,
        style: const TextStyle(fontFamily: 'Cairo'),
      ),
      onTap: onTap,
    );
  }
}

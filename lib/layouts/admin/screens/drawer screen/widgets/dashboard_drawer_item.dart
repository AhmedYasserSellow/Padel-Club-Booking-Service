import 'package:booking/core/utilities/theme/theme.dart';
import 'package:flutter/material.dart';

class DashBoardDrawerItem extends StatelessWidget {
  const DashBoardDrawerItem({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    required this.isSelected,
  });
  final String text;
  final IconData icon;
  final void Function() onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      selectedColor: const Color(0xff000000),
      titleTextStyle: TextStyle(
        color: whiteTextColor,
      ),
      selected: isSelected,
      leading: Icon(
        icon,
        color: isSelected ? Colors.black : whiteTextColor,
      ),
      title: Text(text),
      onTap: onTap,
    );
  }
}

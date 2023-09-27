import 'package:booking/layouts/admin/admin_layout.dart';
import 'package:booking/layouts/home/dialogs/profile_dialog.dart';
import 'package:booking/layouts/home/drawer/widgets/drawer_item.dart';
import 'package:flutter/material.dart';

class UserAndManagerListTile extends StatelessWidget {
  const UserAndManagerListTile(
      {super.key,
      required this.isManager,
      required this.name,
      required this.phone});
  final bool isManager;
  final String name, phone;
  @override
  Widget build(BuildContext context) {
    if (isManager) {
      return DrawerItem(
        isSelected: false,
        text: 'Dashboard',
        icon: Icons.developer_board,
        onTap: () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(
            context,
            AdminView.id,
            arguments: {
              'name': name,
              'phone': phone,
            },
          );
        },
      );
    } else {
      return DrawerItem(
        isSelected: false,
        text: 'Profile',
        icon: Icons.account_circle,
        onTap: () {
          Navigator.pop(context);
          profileDialog(
            context,
            name,
            phone,
            isManager,
          );
        },
      );
    }
  }
}

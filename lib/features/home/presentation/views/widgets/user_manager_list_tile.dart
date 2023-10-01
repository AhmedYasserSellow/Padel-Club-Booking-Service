import 'package:flutter/material.dart';
import 'package:padel_club/features/admin/presetation/views/admin_view.dart';
import 'package:padel_club/features/home/presentation/view_models/home_cubit/home_cubit.dart';
import 'package:padel_club/features/home/presentation/views/widgets/drawer_item.dart';
import 'package:padel_club/features/home/presentation/views/widgets/profile_dialog.dart';

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
          HomeCubit.get(context).scaffoldKey.currentState!.closeDrawer();
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

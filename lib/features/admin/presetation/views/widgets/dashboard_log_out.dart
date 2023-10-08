import 'package:flutter/material.dart';
import 'package:padel_club/features/admin/presetation/view_model/admin_cubit/admin_cubit.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/dashboard_list_tile_item.dart';

class LogOutForDashboard extends StatelessWidget {
  const LogOutForDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DashboardListTileItem(
      onTap: () async {
        AdminCubit.get(context).logOut(context);
      },
      text: 'Log Out',
      icon: Icons.logout,
    );
  }
}

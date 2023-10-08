import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/routes/app_routes.dart';
import 'package:padel_club/features/admin/presetation/view_model/admin_cubit/admin_cubit.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/dashboard_list_tile_item.dart';

class DashboardPages extends StatelessWidget {
  const DashboardPages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dashboardPages.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return DashboardListTileItem(
          text: dashboardPages[index].name,
          icon: dashboardPages[index].icon,
          onTap: () {
            AdminCubit.get(context).navigateToDashboardPages(context, index);
          },
        );
      },
    );
  }
}

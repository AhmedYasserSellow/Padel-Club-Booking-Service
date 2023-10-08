import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/routes/app_routes.dart';
import 'package:padel_club/features/admin/presetation/view_model/admin_cubit/admin_cubit.dart';

class DashboardPagesNavigator extends StatelessWidget {
  const DashboardPagesNavigator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: dashboardPages[AdminCubit.get(context).dashboardPagesIndex]
              .mainWidget,
        ),
      ),
    );
  }
}

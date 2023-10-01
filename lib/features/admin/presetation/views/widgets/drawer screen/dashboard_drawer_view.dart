import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/drawer%20screen/widgets/dashboard_log_out.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/drawer%20screen/widgets/dashboard_pages.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/drawer%20screen/widgets/dashboard_profile_info.dart';

class DashBoardDrawerView extends StatelessWidget {
  const DashBoardDrawerView({
    super.key,
    required this.name,
    required this.phone,
  });
  final String name;
  final String phone;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(12),
          ),
          gradient: LinearGradient(
            colors: [
              AppTheme.racketFirstColor,
              AppTheme.racketSecondColor,
            ],
          ),
        ),
        child: Drawer(
          backgroundColor: Colors.transparent,
          child: SingleChildScrollView(
            child: Column(
              children: [
                DashBoardProfileInfo(
                  name: name,
                  phone: phone,
                ),
                const DashboardPages(),
                const LogOutForDashboard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

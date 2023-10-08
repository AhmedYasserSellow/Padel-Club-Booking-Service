import 'package:flutter/material.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/dashboard_log_out.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/dashboard_pages.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/dashboard_profile_info.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({super.key, required this.name, required this.phone});
  final String name;
  final String phone;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DashBoardProfileInfo(
            name: name,
            phone: phone,
          ),
          const DashboardPages(),
          const LogOutForDashboard()
        ],
      ),
    );
  }
}

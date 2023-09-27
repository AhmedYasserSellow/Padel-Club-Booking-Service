import 'package:booking/components/theme/theme.dart';
import 'package:booking/layouts/admin/dashboard%20drawer/widgets/dashboard_log_out.dart';
import 'package:booking/layouts/admin/dashboard%20drawer/widgets/dashboard_pages.dart';
import 'package:booking/layouts/admin/dashboard%20drawer/widgets/dashboard_profile_info.dart';
import 'package:flutter/material.dart';

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
              racketFirstColor,
              racketSecondColor,
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

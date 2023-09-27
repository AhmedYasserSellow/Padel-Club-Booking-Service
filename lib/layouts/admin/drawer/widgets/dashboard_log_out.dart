import 'package:booking/layouts/admin/drawer/widgets/dashboard_drawer_item.dart';
import 'package:booking/logic/cubit.dart';
import 'package:booking/core/constants/constants.dart';
import 'package:booking/layouts/auth/auth_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOutForDashboard extends StatelessWidget {
  const LogOutForDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DashBoardDrawerItem(
      isSelected: false,
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool(isLoggedIn, false);
        FirebaseAuth.instance.signOut();
        if (context.mounted) {
          AppCubit.get(context).mainPagesIndex = 0;
          AppCubit.get(context).dashboardPagesIndex = 0;
          AppCubit.get(context).loginPageState(0);
          FirebaseMessaging.instance.unsubscribeFromTopic('notify');
          FirebaseMessaging.instance.unsubscribeFromTopic(prefs.getString(id)!);
          FirebaseMessaging.instance.unsubscribeFromTopic('offers');
          FirebaseMessaging.instance.unsubscribeFromTopic('newUsers');
          FirebaseMessaging.instance.unsubscribeFromTopic('0');
          Navigator.pop(context);
          Navigator.pushReplacementNamed(
            context,
            AuthLayout.id,
          );
        }
      },
      text: 'Log Out',
      icon: Icons.logout,
    );
  }
}

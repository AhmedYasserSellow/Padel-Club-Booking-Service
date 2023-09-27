import 'package:booking/layouts/home/drawer/widgets/drawer_item.dart';
import 'package:booking/logic/cubit.dart';
import 'package:booking/components/constants/constants.dart';
import 'package:booking/layouts/auth/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOut extends StatelessWidget {
  const LogOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DrawerItem(
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
            AuthScreen.id,
          );
        }
      },
      text: 'Log Out',
      icon: Icons.logout,
    );
  }
}

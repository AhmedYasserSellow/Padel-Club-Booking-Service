import 'package:booking/core/utilities/constants/constants.dart';
import 'package:booking/core/utilities/services/service_locator.dart';
import 'package:booking/layouts/home/screens/drawer%20screen/widgets/drawer_item.dart';
import 'package:booking/layouts/auth/auth_layout.dart';
import 'package:flutter/material.dart';

class LogOut extends StatelessWidget {
  const LogOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DrawerItem(
      isSelected: false,
      onTap: () async {
        final prefs = await GetInstance.prefs;
        prefs.setBool(isLoggedIn, false);
        GetInstance.auth.signOut();
        if (context.mounted) {
          GetInstance.msg.unsubscribeFromTopic('notify');
          GetInstance.msg.unsubscribeFromTopic(prefs.getString(id)!);
          GetInstance.msg.unsubscribeFromTopic('offers');
          GetInstance.msg.unsubscribeFromTopic('newUsers');
          GetInstance.msg.unsubscribeFromTopic('0');
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

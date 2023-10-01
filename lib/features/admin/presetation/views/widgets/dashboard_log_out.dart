import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/dashboard_drawer_item.dart';
import 'package:padel_club/features/auth/presentation/views/auth_view.dart';

class LogOutForDashboard extends StatelessWidget {
  const LogOutForDashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DashBoardDrawerItem(
      isSelected: false,
      onTap: () async {
        final prefs = await GetInstance.prefs;
        prefs.setBool(PrefsKeys.kIsLoggedIn, false);
        GetInstance.auth.signOut();
        if (context.mounted) {
          GetInstance.msg.unsubscribeFromTopic('notify');
          GetInstance.msg
              .unsubscribeFromTopic(prefs.getString(PrefsKeys.kFirebaseID)!);
          GetInstance.msg.unsubscribeFromTopic('offers');
          GetInstance.msg.unsubscribeFromTopic('newUsers');
          GetInstance.msg.unsubscribeFromTopic('0');
          Navigator.pop(context);
          Navigator.pushReplacementNamed(
            context,
            AuthView.id,
          );
        }
      },
      text: 'Log Out',
      icon: Icons.logout,
    );
  }
}

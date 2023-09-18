import 'package:booking/bloc/cubit.dart';
import 'package:booking/components/constants.dart';
import 'package:booking/drawer/widgets/drawer_item.dart';
import 'package:booking/screens/chat%20screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPages extends StatelessWidget {
  const MainPages({super.key, required this.isManager});
  final bool isManager;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerItem(
          onTap: () {
            AppCubit.get(context).navigateToMainPages(context, 0);
          },
          text: 'Booking',
          icon: Icons.calendar_month,
        ),
        DrawerItem(
          onTap: () {
            AppCubit.get(context).navigateToMainPages(context, 1);
          },
          text: 'Offers',
          icon: Icons.local_offer,
        ),
        DrawerItem(
          onTap: () async {
            if (isManager) {
              AppCubit.get(context).navigateToMainPages(context, 2);
            } else {
              Navigator.pop(context);
              final prefs = await SharedPreferences.getInstance();
              String myID = prefs.getString(id)!;
              if (context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      name: 'Players Service',
                      id: myID,
                      manager: isManager,
                    ),
                  ),
                );
              }
            }
          },
          text: isManager ? 'Chats' : 'Chat',
          icon: Icons.chat,
        ),
        DrawerItem(
          onTap: () {
            AppCubit.get(context).navigateToMainPages(context, 3);
          },
          text: 'Contact Us',
          icon: Icons.info,
        ),
      ],
    );
  }
}

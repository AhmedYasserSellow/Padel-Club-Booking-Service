import 'package:booking/layouts/home/screens/drawer%20screen/widgets/user_manager_list_tile.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo(
      {super.key,
      required this.isManager,
      required this.name,
      required this.phone});
  final bool isManager;
  final String name, phone;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 20,
        ),
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 50,
          child: Image.asset(
            isManager
                ? Theme.of(context).brightness == Brightness.dark
                    ? 'assets/manager.png'
                    : 'assets/manager_light_mode.png'
                : Theme.of(context).brightness == Brightness.light
                    ? 'assets/user.png'
                    : 'assets/user_dark_mode.png',
          ),
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 30),
        ),
        Text(
          phone,
          style: const TextStyle(fontSize: 24),
        ),
        UserAndManagerListTile(
          name: name,
          phone: phone,
          isManager: isManager,
        ),
      ],
    );
  }
}

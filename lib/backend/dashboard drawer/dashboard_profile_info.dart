import 'package:booking/backend/dashboard%20drawer/dashboard_drawer_item.dart';
import 'package:booking/layouts/home_layout.dart';
import 'package:flutter/material.dart';

class DashBoardProfileInfo extends StatelessWidget {
  const DashBoardProfileInfo({
    super.key,
    required this.name,
    required this.phone,
  });

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
          child: Image.asset('assets/manager_light_mode.png'),
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 30),
        ),
        Text(
          phone,
          style: const TextStyle(fontSize: 24),
        ),
        DashBoardDrawerItem(
          isSelected: false,
          text: 'Home',
          icon: Icons.home,
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(
              context,
              HomePage.id,
            );
          },
        ),
      ],
    );
  }
}

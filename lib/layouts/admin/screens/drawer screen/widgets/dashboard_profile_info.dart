import 'package:booking/core/utilities/theme/theme.dart';
import 'package:booking/layouts/admin/screens/drawer%20screen/widgets/dashboard_drawer_item.dart';
import 'package:booking/layouts/home/home_layout.dart';
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
          style: TextStyle(
            fontSize: 30,
            color: whiteTextColor,
          ),
        ),
        Text(
          phone,
          style: TextStyle(
            fontSize: 24,
            color: whiteTextColor,
          ),
        ),
        DashBoardDrawerItem(
          isSelected: false,
          text: 'Home',
          icon: Icons.home,
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(
              context,
              HomeLayout.id,
            );
          },
        ),
      ],
    );
  }
}

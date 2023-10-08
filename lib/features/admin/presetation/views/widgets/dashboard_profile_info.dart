import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';

class DashBoardProfileInfo extends StatelessWidget {
  const DashBoardProfileInfo({
    super.key,
    required this.name,
    required this.phone,
  });

  final String name, phone;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 50,
            child: Image.asset(
              Assets.kManagerLight,
            ),
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 30,
              color: AppTheme.whiteTextColor,
            ),
          ),
          Text(
            phone,
            style: TextStyle(
              fontSize: 24,
              color: AppTheme.whiteTextColor,
            ),
          ),
          // DashBoardDrawerItem(
          //   isSelected: false,
          //   text: 'Home',
          //   icon: Icons.home,
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.pushReplacementNamed(
          //       context,
          //       HomeView.id,
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}

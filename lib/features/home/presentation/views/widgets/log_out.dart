import 'package:flutter/material.dart';
import 'package:padel_club/features/home/presentation/view_models/home_cubit/home_cubit.dart';

import 'package:padel_club/features/home/presentation/views/widgets/drawer_item.dart';

class LogOut extends StatelessWidget {
  const LogOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DrawerItem(
      isSelected: false,
      onTap: () async {
        HomeCubit.get(context).logOut(context);
      },
      text: 'Log Out',
      icon: Icons.logout,
    );
  }
}

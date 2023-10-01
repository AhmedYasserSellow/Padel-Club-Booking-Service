import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/features/auth/presentation/views/widgets/role.dart';

class ChooseRole extends StatelessWidget {
  const ChooseRole({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Are you a ... ?',
          style: TextStyle(
            fontSize: 24,
            color: AppTheme.whiteTextColor,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        // User Role
        const Row(
          children: [
            Role(
              index: 1,
              image: Assets.kUserLight,
              role: 'User',
            ),
            SizedBox(
              width: 12,
            ),
            //Manager Role
            Role(
              index: 2,
              image: Assets.kManagerLight,
              role: 'Manager',
            ),
          ],
        )
      ],
    );
  }
}

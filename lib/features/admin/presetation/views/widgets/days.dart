import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';

class DaysIndex extends StatelessWidget {
  const DaysIndex({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '1 : ${days[0]}',
              style: TextStyle(color: AppTheme.whiteTextColor),
            ),
            Text(
              '2 : ${days[1]}',
              style: TextStyle(color: AppTheme.whiteTextColor),
            ),
            Text(
              '3 : ${days[2]}',
              style: TextStyle(color: AppTheme.whiteTextColor),
            ),
            Text(
              '4 : ${days[3]}',
              style: TextStyle(color: AppTheme.whiteTextColor),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '5 : ${days[4]}',
              style: TextStyle(color: AppTheme.whiteTextColor),
            ),
            Text(
              '6 : ${days[5]}',
              style: TextStyle(color: AppTheme.whiteTextColor),
            ),
            Text(
              '7 : ${days[6]}',
              style: TextStyle(color: AppTheme.whiteTextColor),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

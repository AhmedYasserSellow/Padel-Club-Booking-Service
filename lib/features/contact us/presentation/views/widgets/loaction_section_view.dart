import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/features/contact%20us/presentation/views/widgets/links_button.dart';

class LocationSectionView extends StatelessWidget {
  const LocationSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'TRACK OUR LOCATION',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        LinkButton(
          imagePath: Assets.kCheckIn,
          text: 'REACH US',
          color: AppTheme.locationColor,
          url: 'https://maps.app.goo.gl/R3ckCXUkpav74nPLA',
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

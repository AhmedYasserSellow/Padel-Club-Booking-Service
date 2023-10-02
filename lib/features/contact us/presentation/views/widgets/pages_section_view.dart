import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/features/contact%20us/presentation/views/widgets/links_button.dart';

class PagesSectionView extends StatelessWidget {
  const PagesSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        const Text(
          'OUR PAGES',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
        ),
        const SizedBox(
          height: 24,
        ),
        LinkButton(
          imagePath: Assets.kFacebook,
          text: 'FOLLOW US',
          url: 'https://www.facebook.com/profile.php?id=100091147885086',
          color: AppTheme.faceBookColor,
        ),
        LinkButton(
          imagePath: Assets.kInstagram,
          text: 'FOLLOW US',
          url: 'https://www.instagram.com/padel_club_/',
          color: AppTheme.instagramFirstColor,
          gradient: LinearGradient(
            colors: [
              AppTheme.instagramFirstColor,
              AppTheme.instagramSecondColor,
              AppTheme.instagramThirdColor
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

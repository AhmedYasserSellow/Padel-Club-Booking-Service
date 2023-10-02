import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/features/contact%20us/presentation/views/widgets/links_button.dart';

class WhatsappSectionView extends StatelessWidget {
  const WhatsappSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'CONTACT US',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        LinkButton(
          imagePath: Assets.kWhatsApp,
          text: 'Mostafa Adel',
          url: 'https://wa.me/201060200545',
          color: AppTheme.whatsAppColor,
        ),
        LinkButton(
          imagePath: Assets.kWhatsApp,
          text: 'Karim Mohamed',
          url: 'https://wa.me/201010661328',
          color: AppTheme.whatsAppColor,
        ),
        LinkButton(
          imagePath: Assets.kWhatsApp,
          text: 'Ahmed Ehab',
          url: 'https://wa.me/201004190510',
          color: AppTheme.whatsAppColor,
        ),
        LinkButton(
          imagePath: Assets.kWhatsApp,
          text: 'Ahmed Ashraf',
          url: 'https://wa.me/201021234233',
          color: AppTheme.whatsAppColor,
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

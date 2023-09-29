import 'package:booking/core/utilities/constants/constants.dart';
import 'package:booking/core/utilities/theme/theme.dart';
import 'package:booking/layouts/home/screens/about%20us%20screen/widgets/links_button.dart';
import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            //Pages
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
              color: faceBookColor,
            ),
            LinkButton(
              imagePath: Assets.kInstagram,
              text: 'FOLLOW US',
              url: 'https://www.instagram.com/padel_club_/',
              color: instagramFirstColor,
              gradient: LinearGradient(
                colors: [
                  instagramFirstColor,
                  instagramSecondColor,
                  instagramThirdColor
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
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
              color: locationColor,
              url: 'https://maps.app.goo.gl/R3ckCXUkpav74nPLA',
            ),
            const SizedBox(
              height: 16,
            ),
            //Contact
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
              color: whatsAppColor,
            ),
            LinkButton(
              imagePath: Assets.kWhatsApp,
              text: 'Karim Mohamed',
              url: 'https://wa.me/201010661328',
              color: whatsAppColor,
            ),
            LinkButton(
              imagePath: Assets.kWhatsApp,
              text: 'Ahmed Ehab',
              url: 'https://wa.me/201004190510',
              color: whatsAppColor,
            ),
            LinkButton(
              imagePath: Assets.kWhatsApp,
              text: 'Ahmed Ashraf',
              url: 'https://wa.me/201021234233',
              color: whatsAppColor,
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:booking/components/theme.dart';
import 'package:booking/components/widgets/links_button.dart';
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
              image: 'facebook.png',
              text: 'FOLLOW US',
              url: 'https://www.facebook.com/profile.php?id=100091147885086',
              color: faceBookColor,
            ),
            LinkButton(
              image: 'instagram.png',
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
              image: 'check in.png',
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
              image: 'whatsapp.png',
              text: 'Mostafa Adel',
              url: 'https://wa.me/201060200545',
              color: whatsAppColor,
            ),
            LinkButton(
              image: 'whatsapp.png',
              text: 'Karim Mohamed',
              url: 'https://wa.me/201010661328',
              color: whatsAppColor,
            ),
            LinkButton(
              image: 'whatsapp.png',
              text: 'Ahmed Ehab',
              url: 'https://wa.me/201004190510',
              color: whatsAppColor,
            ),
            LinkButton(
              image: 'whatsapp.png',
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

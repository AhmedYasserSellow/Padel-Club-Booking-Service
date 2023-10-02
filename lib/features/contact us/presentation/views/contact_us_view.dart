import 'package:flutter/material.dart';
import 'package:padel_club/features/contact%20us/presentation/views/widgets/loaction_section_view.dart';
import 'package:padel_club/features/contact%20us/presentation/views/widgets/pages_section_view.dart';
import 'package:padel_club/features/contact%20us/presentation/views/widgets/whatsapp_section_view.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            PagesSectionView(),
            LocationSectionView(),
            WhatsappSectionView(),
          ],
        ),
      ),
    );
  }
}

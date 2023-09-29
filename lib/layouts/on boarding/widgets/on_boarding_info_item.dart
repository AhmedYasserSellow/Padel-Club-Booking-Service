import 'package:booking/core/utilities/theme/theme.dart';
import 'package:flutter/material.dart';

class OnBoardingInfoItem extends StatelessWidget {
  const OnBoardingInfoItem({
    super.key,
    required this.assetImage,
    required this.subtitle,
    required this.title,
  });
  final String assetImage;
  final String title;

  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 7,
        ),
        Image.asset(assetImage),
        const SizedBox(
          height: 24,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: racketFirstColor,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

import 'package:booking/components/theme.dart';
import 'package:flutter/material.dart';

class OnBoardingInfoItem extends StatelessWidget {
  const OnBoardingInfoItem({
    super.key,
    required this.image,
    required this.subtitle,
    required this.title,
  });
  final String image;
  final String title;

  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 7,
        ),
        Image.asset('assets/$image.png'),
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

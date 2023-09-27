import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher_string.dart';

import '../theme/theme.dart';

class LinkButton extends StatelessWidget {
  const LinkButton(
      {super.key,
      required this.image,
      required this.text,
      required this.color,
      required this.url,
      this.gradient});

  final Color color;
  final String image;
  final String text;
  final String url;
  final Gradient? gradient;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrlString(url);
      },
      child: Container(
        margin: const EdgeInsets.only(
          left: 8,
          right: 8,
          bottom: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: gradient,
          color: color,
        ),
        height: 40,
        width: double.infinity,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/$image',
                height: 24,
                width: 24,
              ),
            ),
            Text(
              text,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: whiteTextColor),
            ),
          ],
        ),
      ),
    );
  }
}

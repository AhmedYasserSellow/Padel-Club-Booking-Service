import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OpenPostButton extends StatelessWidget {
  const OpenPostButton({super.key, required this.icon, required this.url});
  final IconData icon;
  final String url;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launchUrlString(url);
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.grey,
            ),
            const Text(
              '   Open Post',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

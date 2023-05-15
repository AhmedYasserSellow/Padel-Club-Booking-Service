import 'package:flutter/material.dart';

void progressDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
              ),
            ),
          ],
        ),
      );
    },
  );
}

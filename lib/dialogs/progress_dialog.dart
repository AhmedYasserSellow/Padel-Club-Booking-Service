import 'package:flutter/material.dart';

void progressDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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

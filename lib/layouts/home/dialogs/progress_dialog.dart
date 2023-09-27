import 'package:flutter/material.dart';

void progressDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const AlertDialog(
        content: Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      );
    },
  );
}

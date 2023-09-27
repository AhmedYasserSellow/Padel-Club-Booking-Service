import 'package:booking/core/theme/theme.dart';
import 'package:flutter/material.dart';

void noInternetSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 1500),
      content: Text(
        'No Internet Connection',
        style: TextStyle(color: whiteTextColor),
      ),
      backgroundColor: Colors.red,
    ),
  );
}

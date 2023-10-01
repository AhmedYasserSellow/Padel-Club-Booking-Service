import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';

void noInternetSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 1500),
      content: Text(
        'No Internet Connection',
        style: TextStyle(color: AppTheme.whiteTextColor),
      ),
      backgroundColor: Colors.red,
    ),
  );
}

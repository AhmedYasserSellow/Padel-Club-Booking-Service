import 'package:booking/core/theme/theme.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  required onTap,
  required String text,
  required Color color,
  Color buttonTextColor = const Color.fromRGBO(255, 255, 255, 1),
  double width = double.infinity,
  bool isLoading = false,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: isLoading
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Center(
                child: CircularProgressIndicator(
                  color: racketFirstColor,
                ),
              ),
            )
          : Center(
              child: Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: buttonTextColor),
            )),
    ),
  );
}

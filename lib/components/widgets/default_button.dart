import 'package:flutter/material.dart';

Widget defaultButton({
  required onTap,
  required String text,
  required Color color,
  Color buttonTextColor = Colors.white,
  double width = double.infinity,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
          child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: buttonTextColor),
      )),
    ),
  );
}

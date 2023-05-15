import 'package:flutter/material.dart';

Widget defaultButton({
  required onTap,
  required String text,
  required Color color,
  Color buttonTextColor = Colors.white,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: double.infinity,
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

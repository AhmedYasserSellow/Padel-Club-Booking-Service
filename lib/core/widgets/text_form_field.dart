import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';

Widget myTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required validate,
  required String label,
  required IconData prefix,
  required BuildContext context,
  required Color color,
  required Color textStyleColor,
  int? limit,
  bool isHidden = false,
  bool isEnabled = true,
  Color focusColor = Colors.blue,
  Color labelColor = Colors.grey,
  Color borderColor = Colors.white,
  Widget? suffix,
  int maxLines = 1,
  Color cursorColor = Colors.white,
}) {
  return TextFormField(
    cursorColor: cursorColor,
    minLines: 1,
    maxLines: maxLines,
    enabled: isEnabled,
    textInputAction: TextInputAction.next,
    obscureText: isHidden,
    style: TextStyle(color: textStyleColor),
    validator: validate,
    controller: controller,
    keyboardType: type,
    decoration: InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: focusColor, width: 2.0),
      ),
      labelStyle: TextStyle(color: labelColor),
      labelText: label,
      prefixIcon: Icon(
        prefix,
        color: color,
      ),
      suffixIcon: suffix,
      suffixIconColor: AppTheme.whiteTextColor,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor.withOpacity(0.3), width: 2.0),
      ),
    ),
  );
}

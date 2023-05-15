import 'package:booking/components/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget myTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  required validate,
  required String label,
  required IconData prefix,
  required BuildContext context,
  required Color color,
  required Color textStyleColor,
  int limit = 20,
  bool isHidden = false,
  bool isEnabled = true,
  Color focusColor = Colors.blue,
  Color labelColor = Colors.grey,
  Widget? suffix,
}) {
  return TextFormField(
    enabled: isEnabled,
    textInputAction: TextInputAction.next,
    obscureText: isHidden,
    inputFormatters: [
      LengthLimitingTextInputFormatter(limit),
    ],
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
      suffixIconColor: textColor,
      border: const OutlineInputBorder(),
    ),
  );
}

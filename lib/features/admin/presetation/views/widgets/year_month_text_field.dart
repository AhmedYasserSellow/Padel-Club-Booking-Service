import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/core/widgets/text_form_field.dart';

class YearAndMonthTextFields extends StatelessWidget {
  const YearAndMonthTextFields({
    super.key,
    required this.yearController,
    required this.monthController,
    required this.title,
  });
  final TextEditingController yearController;
  final TextEditingController monthController;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(color: AppTheme.whiteTextColor),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Expanded(
              child: myTextFormField(
                controller: yearController,
                type: TextInputType.number,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return 'year is required';
                  }
                  if (value.length != 4) {
                    return 'enter a valid year';
                  }
                  return null;
                },
                label: 'Year',
                prefix: Icons.numbers,
                context: context,
                color: AppTheme.whiteTextColor,
                textStyleColor: AppTheme.whiteTextColor,
                labelColor: AppTheme.whiteTextColor,
                focusColor: AppTheme.whiteTextColor,
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: myTextFormField(
                controller: monthController,
                type: TextInputType.number,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return 'month is required';
                  }
                  if (int.tryParse(value)! > 12) {
                    return 'enter a valid month';
                  }
                  return null;
                },
                label: 'Month',
                prefix: Icons.numbers,
                context: context,
                color: AppTheme.whiteTextColor,
                textStyleColor: AppTheme.whiteTextColor,
                labelColor: AppTheme.whiteTextColor,
                focusColor: AppTheme.whiteTextColor,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }
}

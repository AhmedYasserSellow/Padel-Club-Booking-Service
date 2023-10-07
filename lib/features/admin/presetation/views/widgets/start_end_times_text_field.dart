import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/core/widgets/text_form_field.dart';

class StartAndEndTextFields extends StatelessWidget {
  const StartAndEndTextFields({
    super.key,
    required this.title,
    required this.dayIndexController,
    required this.startTimeController,
    required this.endTimeController,
  });
  final String title;
  final TextEditingController dayIndexController;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
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
        myTextFormField(
          controller: dayIndexController,
          type: TextInputType.number,
          validate: (String? value) {
            if (value!.isEmpty) {
              return 'day index is required';
            }

            if (int.tryParse(value)! > 7) {
              return 'enter a valid day number';
            }
            return null;
          },
          label: 'Day Number',
          prefix: Icons.numbers,
          context: context,
          color: AppTheme.whiteTextColor,
          textStyleColor: AppTheme.whiteTextColor,
          labelColor: AppTheme.whiteTextColor,
          focusColor: AppTheme.whiteTextColor,
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Expanded(
              child: myTextFormField(
                controller: startTimeController,
                type: TextInputType.number,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return 'ending time is required';
                  }

                  if (int.tryParse(value)! > 23) {
                    return 'enter a valid starting time';
                  }
                  return null;
                },
                label: 'From',
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
                controller: endTimeController,
                type: TextInputType.number,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return 'ending time is required';
                  }
                  if (int.tryParse(value)! == 0) {
                    return 'please enter 24 instead';
                  }
                  if (int.tryParse(value)! > 23 && int.tryParse(value) != 24) {
                    return 'enter a valid starting time';
                  }
                  return null;
                },
                label: 'To',
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
      ],
    );
  }
}

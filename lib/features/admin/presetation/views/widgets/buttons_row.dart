import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/core/widgets/default_button.dart';

class ButtonsRow extends StatelessWidget {
  const ButtonsRow(
      {super.key,
      this.firstButtonOnTap,
      this.secondButtonOnTap,
      required this.firstButtonTitle,
      required this.secondButtonTitle});
  final void Function()? firstButtonOnTap;
  final void Function()? secondButtonOnTap;
  final String firstButtonTitle;
  final String secondButtonTitle;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: defaultButton(
            text: 'Pin',
            onTap: firstButtonOnTap,
            color: AppTheme.availableColor,
          ),
        ),
        const SizedBox(
          width: 24,
        ),
        Expanded(
          child: defaultButton(
            color: AppTheme.bookedColor,
            onTap: secondButtonOnTap,
            text: 'Unpin',
          ),
        ),
      ],
    );
  }
}

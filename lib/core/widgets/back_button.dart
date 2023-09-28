import 'package:booking/core/utilities/theme/logic/theme_cubit.dart';
import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        'Back',
        style: TextStyle(
          color: ThemeCubit.get(context).iconAndTextColor,
        ),
      ),
    );
  }
}

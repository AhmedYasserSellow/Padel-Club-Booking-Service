import 'package:booking/layouts/home/logic/home_cubit.dart';
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
          color: HomeCubit.get(context).iconAndTextColor,
        ),
      ),
    );
  }
}

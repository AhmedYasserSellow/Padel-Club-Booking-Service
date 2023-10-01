import 'package:flutter/material.dart';
import 'package:padel_club/features/home/presentation/view_models/home_cubit/home_cubit.dart';

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

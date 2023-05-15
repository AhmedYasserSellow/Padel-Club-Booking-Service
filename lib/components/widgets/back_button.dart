import 'package:flutter/material.dart';

import '../../bloc/cubit.dart';

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
          color: AppCubit.get(context).iconAndTextColor,
        ),
      ),
    );
  }
}

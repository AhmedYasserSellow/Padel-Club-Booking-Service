import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';

class GiveAwaysScreen extends StatelessWidget {
  const GiveAwaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(
                Theme.of(context).brightness == Brightness.dark
                    ? Assets.kSadBallDark
                    : Assets.kSadBallLight,
              ),
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'There is no giveaways right now',
              style: TextStyle(
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}

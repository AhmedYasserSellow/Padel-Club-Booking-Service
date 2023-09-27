import 'package:booking/logic/cubit.dart';
import 'package:flutter/material.dart';

class GiveAwasyScreen extends StatelessWidget {
  const GiveAwasyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(
                AppCubit.get(context).brightness == Brightness.light
                    ? 'assets/no_offer.png'
                    : 'assets/no_offer_dark_mode.png',
              ),
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'There is no giveaways right now',
              style: TextStyle(
                color: AppCubit.get(context).iconAndTextColor,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:booking/core/utilities/theme/logic/theme_cubit.dart';
import 'package:flutter/material.dart';

class NoUsersScreen extends StatelessWidget {
  const NoUsersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(
                ThemeCubit.get(context).brightness == Brightness.light
                    ? 'assets/no_offer.png'
                    : 'assets/no_offer_dark_mode.png',
              ),
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'There is no users right now',
              style: TextStyle(
                color: ThemeCubit.get(context).iconAndTextColor,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}

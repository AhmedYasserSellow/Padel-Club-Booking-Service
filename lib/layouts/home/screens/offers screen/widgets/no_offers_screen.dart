import 'package:booking/core/utilities/theme/logic/theme_cubit.dart';
import 'package:booking/core/utilities/theme/theme.dart';
import 'package:flutter/material.dart';

class NoOffersScreen extends StatelessWidget {
  const NoOffersScreen({
    super.key,
    required this.isOpenedFromDashboard,
  });

  final bool isOpenedFromDashboard;

  @override
  Widget build(BuildContext context) {
    return Center(
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
            isOpenedFromDashboard
                ? 'Add offers little shit'
                : 'There is no offers right now',
            style: TextStyle(
              color: isOpenedFromDashboard
                  ? whiteTextColor
                  : ThemeCubit.get(context).iconAndTextColor,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}

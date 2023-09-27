import 'package:booking/core/theme/theme.dart';
import 'package:booking/logic/cubit.dart';
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
            isOpenedFromDashboard
                ? 'Add offers little shit'
                : 'There is no offers right now',
            style: TextStyle(
              color: isOpenedFromDashboard
                  ? whiteTextColor
                  : AppCubit.get(context).iconAndTextColor,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}

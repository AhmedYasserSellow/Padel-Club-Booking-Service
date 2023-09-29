import 'package:booking/core/utilities/constants/constants.dart';
import 'package:booking/layouts/home/logic/home_cubit.dart';
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
              Theme.of(context).brightness == Brightness.dark
                  ? Assets.kSadBallDark
                  : Assets.kSadBallLight,
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
                  : HomeCubit.get(context).iconAndTextColor,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}

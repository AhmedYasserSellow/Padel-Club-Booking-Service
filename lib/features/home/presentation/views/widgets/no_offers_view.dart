import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/features/home/presentation/view_models/home_cubit/home_cubit.dart';

class NoOffersView extends StatelessWidget {
  const NoOffersView({
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
                  ? AppTheme.whiteTextColor
                  : HomeCubit.get(context).iconAndTextColor,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}

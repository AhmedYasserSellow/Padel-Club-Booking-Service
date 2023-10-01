import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/features/home/presentation/view_models/home_cubit/home_cubit.dart';

class NoUsersView extends StatelessWidget {
  const NoUsersView({
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
                HomeCubit.get(context).brightness == Brightness.light
                    ? Assets.kSadBallLight
                    : Assets.kSadBallDark,
              ),
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'There is no users right now',
              style: TextStyle(
                color: HomeCubit.get(context).iconAndTextColor,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}

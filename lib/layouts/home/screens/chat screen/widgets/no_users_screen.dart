import 'package:booking/core/utilities/constants/constants.dart';
import 'package:booking/layouts/home/logic/home_cubit.dart';
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

import 'package:booking/components/theme/theme.dart';
import 'package:booking/layouts/on%20boarding/widgets/screens_list.dart';
import 'package:booking/logic/cubit.dart';
import 'package:booking/logic/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressArrow extends StatelessWidget {
  const ProgressArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return Column(
          children: [
            Stack(alignment: Alignment.center, children: [
              SizedBox(
                height: 120,
                width: 120,
                child: CircularProgressIndicator(
                  backgroundColor: const Color(0xffD3E4FF),
                  color: const Color(0xff1B72C0),
                  value: (AppCubit.get(context).onBoardingIndex + 1) /
                      onBoardingInfoSection.length,
                ),
              ),
              GestureDetector(
                onTap: () => AppCubit.get(context).changeOnBoardingScreenIndex(
                    context, AppCubit.get(context).onBoardingIndex),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: racketFirstColor,
                  child: Icon(
                    Icons.arrow_forward,
                    color: whiteTextColor,
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 48,
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/features/on%20boarding/presentation/view_models/on_boarding_cubit/on_boarding_cubit.dart';
import 'package:padel_club/features/on%20boarding/presentation/views/widgets/on_boarding_info_item.dart';

class ProgressArrow extends StatelessWidget {
  const ProgressArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
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
                  value: (OnBoardingCubit.get(context).onBoardingIndex + 1) /
                      onBoardingPages.length,
                ),
              ),
              GestureDetector(
                onTap: () => OnBoardingCubit.get(context)
                    .changeOnBoardingScreenIndex(
                        context, OnBoardingCubit.get(context).onBoardingIndex),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: AppTheme.racketFirstColor,
                  child: Icon(
                    Icons.arrow_forward,
                    color: AppTheme.whiteTextColor,
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

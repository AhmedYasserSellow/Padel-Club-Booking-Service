import 'package:booking/layouts/on%20boarding/widgets/progress_arrow.dart';
import 'package:booking/layouts/on%20boarding/widgets/screens_list.dart';
import 'package:booking/logic/cubit.dart';
import 'package:booking/logic/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                onBoardingInfoSection[AppCubit.get(context).onBoardingIndex],
                const Expanded(
                  child: SizedBox(),
                ),
                const ProgressArrow()
              ],
            ),
          ),
        );
      },
    );
  }
}

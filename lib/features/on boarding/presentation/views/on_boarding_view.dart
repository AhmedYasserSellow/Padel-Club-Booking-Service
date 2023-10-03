import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/features/on%20boarding/presentation/view_models/on_boarding_cubit/on_boarding_cubit.dart';
import 'package:padel_club/features/on%20boarding/presentation/views/widgets/on_boarding_info_item.dart';
import 'package:padel_club/features/on%20boarding/presentation/views/widgets/progress_arrow.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: BlocBuilder<OnBoardingCubit, OnBoardingState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              backgroundColor: Colors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  onBoardingPages[OnBoardingCubit.get(context).onBoardingIndex],
                  const Expanded(
                    child: SizedBox(),
                  ),
                  const ProgressArrow()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

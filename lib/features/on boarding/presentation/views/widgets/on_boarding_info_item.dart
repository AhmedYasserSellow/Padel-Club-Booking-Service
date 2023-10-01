import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/features/on%20boarding/data/models/on_boarding_model.dart';

class OnBoardingInfoItem extends StatelessWidget {
  const OnBoardingInfoItem({
    super.key,
    required this.onBoardingModel,
  });
  final OnBoardingModel onBoardingModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 7,
        ),
        Image.asset(onBoardingModel.assetImage),
        const SizedBox(
          height: 24,
        ),
        Text(
          onBoardingModel.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          onBoardingModel.subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.racketFirstColor,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

List<OnBoardingInfoItem> onBoardingPages = [
  OnBoardingInfoItem(
    onBoardingModel: OnBoardingModel(
      assetImage: Assets.kPitch,
      title: 'Booking Service',
      subtitle:
          'Padel Club application provides you a booking service to our padel stadium so\n Enjoy Our Game',
    ),
  ),
  OnBoardingInfoItem(
    onBoardingModel: OnBoardingModel(
      title: 'Offers Service',
      assetImage: Assets.kOffers,
      subtitle:
          'Also we provide you an offers screen to get notified with our new offers\nEnjoy Our Offers',
    ),
  ),
  OnBoardingInfoItem(
    onBoardingModel: OnBoardingModel(
      assetImage: Assets.kGiveAways,
      subtitle:
          'Also we provide you a giveaways screen to know our new giveaways\nEnjoy Our Gifts',
      title: 'Giveaways Service',
    ),
  ),
  OnBoardingInfoItem(
    onBoardingModel: OnBoardingModel(
      assetImage: Assets.kChatService,
      subtitle:
          'Also we provide you a chat service so you can reach us at any time\nWelcome To Our Community',
      title: 'Chat Service',
    ),
  )
];

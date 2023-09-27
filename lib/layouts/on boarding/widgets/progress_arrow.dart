import 'package:booking/components/constants/constants.dart';
import 'package:booking/components/theme/theme.dart';
import 'package:booking/layouts/auth/login_page.dart';
import 'package:booking/layouts/on%20boarding/widgets/screens_list.dart';
import 'package:booking/logic/cubit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressArrow extends StatefulWidget {
  const ProgressArrow({super.key});

  @override
  State<ProgressArrow> createState() => _ProgressArrowState();
}

class _ProgressArrowState extends State<ProgressArrow> {
  @override
  Widget build(BuildContext context) {
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
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              if (context.mounted) {
                AppCubit.get(context).onBoardingIndex += 1;
                if (AppCubit.get(context).onBoardingIndex ==
                    onBoardingInfoSection.length) {
                  prefs.setBool(isOnBoarding, false);
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, AuthScreen.id);
                  }
                } else {
                  setState(() {});
                }
              }
            },
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
  }
}

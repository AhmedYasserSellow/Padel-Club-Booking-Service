import 'package:booking/components/constants.dart';
import 'package:booking/components/theme.dart';
import 'package:booking/layouts/auth/login_page.dart';
import 'package:booking/screens/on%20boarding%20screen/widgets/screens_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            onBoardingInfoSection[index],
            const Expanded(
              child: SizedBox(),
            ),
            Stack(alignment: Alignment.center, children: [
              SizedBox(
                height: 120,
                width: 120,
                child: CircularProgressIndicator(
                  backgroundColor: const Color(0xffD3E4FF),
                  color: const Color(0xff1B72C0),
                  value: (index + 1) / onBoardingInfoSection.length,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  index += 1;
                  if (index == onBoardingInfoSection.length) {
                    prefs.setBool(isOnBoarding, false);
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, LoginPage.id);
                    }
                  } else {
                    setState(() {});
                  }
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: racketFirstColor,
                  child: Icon(
                    Icons.arrow_forward,
                    color: textColor,
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 48,
            ),
          ],
        ),
      ),
    );
  }
}

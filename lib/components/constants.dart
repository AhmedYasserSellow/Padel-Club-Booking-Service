import 'package:booking/layouts/admin/screens/notification.dart';
import 'package:booking/components/models/page_model.dart';
import 'package:booking/layouts/home/screens/about%20us/about_us_screen.dart';
import 'package:booking/layouts/home/screens/booking%20screen/booking_screen.dart';
import 'package:booking/layouts/home/screens/chat%20screen/chat_screen.dart';
import 'package:booking/layouts/home/screens/chat%20screen/chats_screen.dart';
import 'package:booking/layouts/home/screens/giveaway%20screen/give_away_screen.dart';
import 'package:booking/layouts/home/screens/offers%20screen/offers_screen.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../layouts/admin/dashboard.dart';
import '../layouts/home/home_layout.dart';
import '../layouts/auth/login_page.dart';
import '../layouts/home/screens/splash screen/splash_screen.dart';
import 'theme.dart';

int finalYear = DateTime.now().year + 1;

String pending = 'Pending';
String booked = 'Booked';
String academy = 'Academy';

//Shared Preferences variables
String isLoggedIn = 'isLoggedin';
String yourName = 'Name';
String yourPhone = 'Phone';
String dev = 'dev';
String id = 'ID';
String isOnBoarding = 'isOnBoarding';
String isPremessionShowed = 'isPremessionShowed';

List<String> clock = [
  '12:00 AM',
  '1:00 AM',
  '2:00 AM',
  '3:00 AM',
  '4:00 AM',
  '5:00 AM',
  '6:00 AM',
  '7:00 AM',
  '8:00 AM',
  '9:00 AM',
  '10:00 AM',
  '11:00 AM',
  '12:00 PM',
  '1:00 PM',
  '2:00 PM',
  '3:00 PM',
  '4:00 PM',
  '5:00 PM',
  '6:00 PM',
  '7:00 PM',
  '8:00 PM',
  '9:00 PM',
  '10:00 PM',
  '11:00 PM',
];
List<String> abc = [
  'a',
  'b',
  'c',
  'd',
  'e',
  'f',
  'g',
  'h',
  'i',
  'j',
  'k',
  'l',
  'm',
  'm',
  'o',
  'p',
  'q',
  'r',
  's',
  't',
  'u',
  'v',
  'w',
  'x',
  'y',
  'z',
];

List<PageModel> mainPages({
  required bool manager,
  required String myName,
  required String firebaseID,
}) =>
    [
      PageModel(
        icon: Icons.calendar_month,
        name: 'Booking',
        mainWidget: BookingScreen(
          firebaseID: firebaseID,
        ),
      ),
      PageModel(
        icon: Icons.local_offer,
        name: 'Offers',
        mainWidget: const OffersScreen(
          removeFeature: false,
        ),
      ),
      PageModel(
        icon: Icons.card_giftcard,
        name: 'Giveaways',
        mainWidget: const GiveAwasyScreen(),
      ),
      manager
          ? PageModel(
              icon: Icons.chat,
              name: 'Chats',
              mainWidget: ChatsScreen(
                manager: manager,
                myName: myName,
              ),
            )
          : PageModel(
              icon: Icons.chat,
              name: 'Chat',
              mainWidget: ChatScreen(
                name: 'Players Service',
                id: firebaseID,
                manager: manager,
              ),
            ),
      PageModel(
        icon: Icons.info,
        name: 'Contact Us',
        mainWidget: const ContactUsScreen(),
      ),
    ];

final connection = InternetConnectionCheckerPlus.createInstance(
  checkInterval: const Duration(milliseconds: 500),
  checkTimeout: const Duration(milliseconds: 500),
);
void noInternetSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 1500),
      content: Text(
        'No Internet Connection',
        style: TextStyle(color: textColor),
      ),
      backgroundColor: Colors.red,
    ),
  );
}

Map<String, Widget Function(BuildContext)> appRoutes = {
  Splash.id: (context) => const Splash(),
  HomePage.id: (context) => const HomePage(),
  LoginPage.id: (context) => const LoginPage(),
  DashBoard.id: (context) => const DashBoard(),
  NotificationScreen.id: (context) => const NotificationScreen(),
};

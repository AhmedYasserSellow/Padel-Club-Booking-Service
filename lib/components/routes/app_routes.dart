import 'package:booking/components/models/page_model.dart';
import 'package:booking/layouts/admin/dashboard_view.dart';
import 'package:booking/layouts/admin/screens/academy.dart';
import 'package:booking/layouts/admin/screens/offers.dart';
import 'package:booking/layouts/admin/screens/pin_times.dart';
import 'package:booking/layouts/admin/screens/prices.dart';
import 'package:booking/layouts/admin/screens/years.dart';
import 'package:booking/layouts/auth/login_page.dart';
import 'package:booking/layouts/home/home_layout.dart';
import 'package:booking/layouts/home/screens/about%20us/about_us_screen.dart';
import 'package:booking/layouts/home/screens/booking%20screen/booking_screen.dart';
import 'package:booking/layouts/home/screens/chat%20screen/chat_screen.dart';
import 'package:booking/layouts/home/screens/chat%20screen/chats_screen.dart';
import 'package:booking/layouts/home/screens/giveaway%20screen/give_away_screen.dart';
import 'package:booking/layouts/home/screens/offers%20screen/offers_screen.dart';
import 'package:booking/layouts/splash/splash_screen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  SplashScreen.id: (context) => const SplashScreen(),
  HomeScreen.id: (context) => const HomeScreen(),
  AuthScreen.id: (context) => const AuthScreen(),
  DashBoardView.id: (context) => const DashBoardView(),
};
List<PageModel> appPages({
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

List<PageModel> dashboardPages = [
  PageModel(
    icon: Icons.pin_drop,
    name: 'Pin',
    mainWidget: PinTimes(),
  ),
  PageModel(
    icon: Icons.sports_tennis,
    name: 'Academy',
    mainWidget: ControlAcademy(),
  ),
  PageModel(
    icon: Icons.local_offer,
    name: 'Offers',
    mainWidget: ControlOffers(),
  ),
  PageModel(
    icon: Icons.calendar_month,
    name: 'Database Years',
    mainWidget: AddYearsToDB(),
  ),
  PageModel(
    icon: Icons.price_change,
    name: 'Prices',
    mainWidget: PricesScreen(),
  )
];

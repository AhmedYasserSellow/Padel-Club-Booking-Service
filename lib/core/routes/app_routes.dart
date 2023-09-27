import 'package:booking/core/models/page_model.dart';
import 'package:booking/layouts/admin/admin_layout.dart';
import 'package:booking/layouts/admin/screens/academy.dart';
import 'package:booking/layouts/admin/screens/notification.dart';
import 'package:booking/layouts/admin/screens/offers.dart';
import 'package:booking/layouts/admin/screens/pin_times.dart';
import 'package:booking/layouts/admin/screens/prices.dart';
import 'package:booking/layouts/admin/screens/years.dart';
import 'package:booking/layouts/auth/auth_layout.dart';
import 'package:booking/layouts/home/home_layout.dart';
import 'package:booking/layouts/home/screens/about%20us%20screen/about_us_screen.dart';
import 'package:booking/layouts/home/screens/booking%20screen/booking_screen.dart';
import 'package:booking/layouts/home/screens/chat%20screen/chat_screen.dart';
import 'package:booking/layouts/home/screens/chat%20screen/widgets/manager_chat_screen.dart';
import 'package:booking/layouts/home/screens/giveaway%20screen/give_away_screen.dart';
import 'package:booking/layouts/home/screens/offers%20screen/offers_screen.dart';
import 'package:booking/layouts/splash/splash_layout.dart';
import 'package:booking/layouts/on%20boarding/widgets/on_boarding_info_item.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  SplashLayout.id: (context) => const SplashLayout(),
  HomeLayout.id: (context) => const HomeLayout(),
  AuthLayout.id: (context) => const AuthLayout(),
  AdminView.id: (context) => const AdminView(),
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
  ),
  PageModel(
    icon: Icons.notifications,
    name: 'Notifications',
    mainWidget: const NotificationScreen(),
  ),
];

List<OnBoardingInfoItem> onBoardingPages = const [
  OnBoardingInfoItem(
    image: 'pitch',
    title: 'Booking Service',
    subtitle:
        'Padel Club application provides you a booking service to our padel stadium so\n Enjoy Our Game',
  ),
  OnBoardingInfoItem(
    title: 'Offers Service',
    image: 'offers',
    subtitle:
        'Also we provide you an offers screen to get notified with our new offers\nEnjoy Our Offers',
  ),
  OnBoardingInfoItem(
    image: 'giveaways',
    subtitle:
        'Also we provide you a giveaways screen to know our new giveaways\nEnjoy Our Gifts',
    title: 'Giveaways Service',
  ),
  OnBoardingInfoItem(
    image: 'chats',
    subtitle:
        'Also we provide you a chat service so you can reach us at any time\nWelcome To Our Community',
    title: 'Chat Service',
  )
];

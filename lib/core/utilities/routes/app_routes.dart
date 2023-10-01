import 'package:flutter/material.dart';
import 'package:padel_club/core/models/page_model.dart';
import 'package:padel_club/features/admin/presetation/views/academy_view.dart';
import 'package:padel_club/features/admin/presetation/views/admin_view.dart';
import 'package:padel_club/features/admin/presetation/views/notification_view.dart';
import 'package:padel_club/features/admin/presetation/views/offers_view.dart';
import 'package:padel_club/features/admin/presetation/views/pin_times_view.dart';
import 'package:padel_club/features/admin/presetation/views/prices_view.dart';
import 'package:padel_club/features/admin/presetation/views/years_view.dart';
import 'package:padel_club/features/auth/presentation/views/auth_view.dart';
import 'package:padel_club/features/home/presentation/views/about_us_view.dart';
import 'package:padel_club/features/home/presentation/views/booking_view.dart';
import 'package:padel_club/features/home/presentation/views/chat_view.dart';
import 'package:padel_club/features/home/presentation/views/give_away_screen.dart';
import 'package:padel_club/features/home/presentation/views/home_view.dart';
import 'package:padel_club/features/home/presentation/views/offers_view.dart';
import 'package:padel_club/features/home/presentation/views/widgets/select_chat_view.dart';

import 'package:padel_club/features/splash/presentation/views/splash_view.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  SplashView.id: (context) => const SplashView(),
  HomeView.id: (context) => const HomeView(),
  AuthView.id: (context) => const AuthView(),
  AdminView.id: (context) => const AdminView(),
};
List<PageModel> homePages({
  required bool manager,
  required String myName,
  required String firebaseID,
}) =>
    [
      PageModel(
        icon: Icons.calendar_month,
        name: 'Booking',
        mainWidget: BookingView(
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
        mainWidget: const GiveAwaysScreen(),
      ),
      manager
          ? PageModel(
              icon: Icons.chat,
              name: 'Chats',
              mainWidget: SelectChatView(
                manager: manager,
                myName: myName,
              ),
              shimmerWidget: SelectChatView(
                manager: manager,
                myName: myName,
              ),
            )
          : PageModel(
              icon: Icons.chat,
              name: 'Chat',
              mainWidget: ChatView(
                name: 'Players Service',
                id: firebaseID,
                manager: manager,
              ),
              shimmerWidget: ChatView(
                name: 'Players Service',
                id: firebaseID,
                manager: manager,
              ),
            ),
      PageModel(
        icon: Icons.info,
        name: 'Contact Us',
        mainWidget: const AboutUsView(),
        shimmerWidget: const AboutUsView(),
      ),
    ];

List<PageModel> dashboardPages = [
  PageModel(
    icon: Icons.pin_drop,
    name: 'Pin',
    mainWidget: const PinTimes(),
  ),
  PageModel(
    icon: Icons.sports_tennis,
    name: 'Academy',
    mainWidget: const ControlAcademy(),
  ),
  PageModel(
    icon: Icons.local_offer,
    name: 'Offers',
    mainWidget: const ControlOffers(),
  ),
  PageModel(
    icon: Icons.calendar_month,
    name: 'Database Years',
    mainWidget: const AddYearsToDB(),
  ),
  PageModel(
    icon: Icons.price_change,
    name: 'Prices',
    mainWidget: const PricesScreen(),
  ),
  PageModel(
    icon: Icons.notifications,
    name: 'Notifications',
    mainWidget: const NotificationView(),
  ),
];

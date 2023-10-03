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
import 'package:padel_club/features/chat/presentation/views/widgets/select_chat_view.dart';
import 'package:padel_club/features/contact%20us/presentation/views/contact_us_view.dart';
import 'package:padel_club/features/booking/presentation/views/booking_view.dart';
import 'package:padel_club/features/chat/presentation/views/chat_view.dart';
import 'package:padel_club/features/home/presentation/views/home_view.dart';
import 'package:padel_club/features/offers/presentation/views/offers_view.dart';
import 'package:padel_club/features/splash/presentation/views/splash_view.dart';

part 'admin_routes.dart';
part 'home_routes.dart';

Map<String, Widget Function(BuildContext)> appRoutes = {
  SplashView.id: (context) => const SplashView(),
  HomeView.id: (context) => const HomeView(),
  AuthView.id: (context) => const AuthView(),
  AdminView.id: (context) => const AdminView(),
};

part of 'app_routes.dart';

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

part of 'app_routes.dart';

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
        mainWidget: const OffersView(),
      ),
      manager
          ? PageModel(
              icon: Icons.chat,
              name: 'Chats',
              mainWidget: SelectChatView(
                firebaseID: firebaseID,
                manager: manager,
                myName: myName,
              ),
              shimmerWidget: SelectChatView(
                firebaseID: firebaseID,
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

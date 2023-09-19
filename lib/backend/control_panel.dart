import 'package:booking/components/theme.dart';
import 'package:booking/backend/screens/notification.dart';
import 'package:booking/backend/screens/offers.dart';
import 'package:booking/backend/screens/prices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cubit.dart';
import '../bloc/states.dart';
import 'screens/academy.dart';
import 'screens/pin_times.dart';
import 'screens/years.dart';

List screens = [
  PinTimes(),
  ControlAcademy(),
  ControlOffers(),
  AddYearsToDB(),
  PricesScreen()
];

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});
  static String id = 'CMD';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                racketFirstColor,
                racketSecondColor,
              ],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              leading: BackButton(
                color: textColor,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      NotificationScreen.id,
                    );
                  },
                  icon: const Icon(
                    Icons.notifications_outlined,
                  ),
                  color: textColor,
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
              title: Text(
                'Dashboard',
                style: TextStyle(color: textColor),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: textColor,
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.transparent,
              onTap: (value) {
                AppCubit.get(context).changeBottomNavIndexForDB(value);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.pin_drop),
                  label: 'Pinning',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.sports_tennis),
                  label: 'Academy',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.local_offer_outlined),
                  label: 'Offers',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month_outlined),
                  label: 'Years',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.price_change),
                  label: 'Prices',
                ),
              ],
              showUnselectedLabels: false,
              currentIndex: AppCubit.get(context).navIndexForDB,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: screens[AppCubit.get(context).navIndexForDB],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

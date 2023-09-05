import 'package:booking/components/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cubit.dart';
import '../bloc/states.dart';
import 'screens/academy.dart';
import 'screens/pin_times.dart';
import 'screens/years.dart';

List screens = [
  PinTimes(),
  ControlAcademy(),
  AddYearsToDB(),
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
                rackerSecondColor,
              ],
            ),
          ),
          child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: textColor,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'Dashboard',
                style: TextStyle(color: textColor),
              ),
              centerTitle: true,
              backgroundColor: racketFirstColor,
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: textColor,
              unselectedItemColor: Colors.grey,
              backgroundColor: rackerSecondColor,
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
                  icon: Icon(Icons.numbers),
                  label: 'Years',
                ),
              ],
              showUnselectedLabels: false,
              currentIndex: AppCubit.get(context).navIndexForDB,
            ),
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  racketFirstColor,
                  rackerSecondColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: screens[AppCubit.get(context).navIndexForDB],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

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

class ControlPanel extends StatelessWidget {
  const ControlPanel({super.key});
  static String id = 'CMD';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: AppCubit.get(context).iconAndTextColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Control Panel',
              style: TextStyle(color: AppCubit.get(context).iconAndTextColor),
            ),
            centerTitle: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            actions: [
              IconButton(
                onPressed: () {
                  AppCubit.get(context).changeTheme();
                },
                icon: Icon(
                  AppCubit.get(context).modeIcon,
                ),
                color: AppCubit.get(context).iconAndTextColor,
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
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
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: screens[AppCubit.get(context).navIndexForDB],
              ),
            ),
          ),
        );
      },
    );
  }
}

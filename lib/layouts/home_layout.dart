import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/cubit.dart';
import '../bloc/states.dart';
import '../components/constants.dart';

import '../database/control_panel.dart';
import '../dialogs/profile_dialog.dart';
import '../screens/about us/about_us_screen.dart';
import '../screens/booking screen/booking_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });
  static String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool manager = false;
  String name = '';
  String phone = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future loadState() async {
    final prefs = await SharedPreferences.getInstance();
    manager = prefs.getBool(dev)!;
    name = prefs.getString(yourName)!;
    phone = prefs.getString(yourPhone)!;
  }

  @override
  void initState() {
    super.initState();
    loadState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: connection.onStatusChange,
        builder: (context, ethernetSnapshot) {
          return StreamBuilder(
              stream: Stream.fromFuture(connection.connectionStatus),
              builder: (context, internetSnapshot) {
                return StreamBuilder(
                    stream: Stream.fromFuture(loadState()),
                    builder: (context, snapshot) {
                      return BlocConsumer<AppCubit, AppStates>(
                        builder: (context, state) {
                          return Scaffold(
                              appBar: AppBar(
                                leading: IconButton(
                                  icon: Icon(
                                    Icons.account_circle,
                                    color:
                                        AppCubit.get(context).iconAndTextColor,
                                  ),
                                  onPressed: () {
                                    profileDialog(
                                        context, formKey, name, phone, manager);
                                  },
                                ),
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                toolbarHeight: 56,
                                centerTitle: true,
                                title: Image.asset(
                                  AppCubit.get(context).isLightMode
                                      ? 'assets/logo.png'
                                      : 'assets/logodark.png',
                                  height: 72,
                                ),
                                actions: [
                                  IconButton(
                                    onPressed: () {
                                      AppCubit.get(context).changeTheme();
                                    },
                                    icon: Icon(
                                      AppCubit.get(context).modeIcon,
                                    ),
                                    color:
                                        AppCubit.get(context).iconAndTextColor,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  //dev mode ---------------------------------
                                  manager
                                      ? Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, ControlPanel.id);
                                              },
                                              icon: const Icon(
                                                  Icons.developer_board),
                                              color: AppCubit.get(context)
                                                  .iconAndTextColor,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                              bottomNavigationBar: BottomNavigationBar(
                                onTap: (value) {
                                  AppCubit.get(context)
                                      .changeBottomNavIndex(value);
                                },
                                items: const [
                                  BottomNavigationBarItem(
                                    icon: Icon(Icons.calendar_month_outlined),
                                    label: 'Booking',
                                  ),
                                  BottomNavigationBarItem(
                                    icon: Icon(Icons.info_outline),
                                    label: 'About',
                                  ),
                                ],
                                showUnselectedLabels: false,
                                currentIndex: AppCubit.get(context).navIndex,
                              ),
                              body: (internetSnapshot.data ==
                                          InternetConnectionStatus.connected ||
                                      ethernetSnapshot.data ==
                                          InternetConnectionStatus.connected)
                                  ? AppCubit.get(context).navIndex == 0
                                      ? const BookingScreen()
                                      : const AboutUsScreen()
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    ));
                        },
                        listener: (context, state) {},
                      );
                    });
              });
        });
  }
}

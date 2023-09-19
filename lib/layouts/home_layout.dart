import 'package:booking/components/constants.dart';
import 'package:booking/components/notifications.dart';
import 'package:booking/drawer/drawer_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/cubit.dart';
import '../bloc/states.dart';

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
  String firebaseID = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Future loadState() async {
    final prefs = await SharedPreferences.getInstance();
    manager = prefs.getBool(dev)!;
    name = prefs.getString(yourName)!;
    phone = prefs.getString(yourPhone)!;
    firebaseID = prefs.getString(id)!;
  }

  firebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationService().showNotification(
        title: message.notification!.title,
        body: message.notification!.body,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    loadState();
    firebaseMessaging();
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
                      return BlocBuilder<AppCubit, AppStates>(
                        builder: (context, state) {
                          return Scaffold(
                            key: scaffoldKey,
                            drawer: const HomeDrawer(),
                            appBar: AppBar(
                              scrolledUnderElevation: 0,
                              leading: IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  color: AppCubit.get(context).iconAndTextColor,
                                ),
                                onPressed: () {
                                  scaffoldKey.currentState!.openDrawer();
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
                            ),
                            body: (internetSnapshot.data ==
                                        InternetConnectionStatus.connected ||
                                    ethernetSnapshot.data ==
                                        InternetConnectionStatus.connected)
                                ? appScreens(
                                    firebaseID: firebaseID,
                                    myName: name,
                                    manager: manager,
                                  )[AppCubit.get(context).mainPagesIndex]
                                : Center(
                                    child: CircularProgressIndicator(
                                      color: Theme.of(context).indicatorColor,
                                    ),
                                  ),
                          );
                        },
                      );
                    });
              });
        });
  }
}

import 'package:booking/bloc/cubit.dart';
import 'package:booking/components/constants.dart';
import 'package:booking/drawer/widgets/drawer_item.dart';
import 'package:booking/drawer/widgets/main_pages.dart';
import 'package:booking/drawer/widgets/profile_info.dart';
import 'package:booking/drawer/widgets/user_manager_list_tile.dart';
import 'package:booking/layouts/login%20Layout/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  String name = '';
  String phone = '';
  bool isManager = false;

  Future loadState() async {
    final prefs = await SharedPreferences.getInstance();
    isManager = prefs.getBool(dev)!;
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
        stream: Stream.fromFuture(loadState()),
        builder: (context, snapshot) {
          return SafeArea(
            child: Drawer(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                children: [
                  ProfileInfo(
                    name: name,
                    phone: phone,
                    isManager: isManager,
                  ),
                  UserAndManagerListTile(
                    name: name,
                    phone: phone,
                    isManager: isManager,
                  ),
                  MainPages(
                    isManager: isManager,
                  ),
                  DrawerItem(
                    onTap: () {
                      AppCubit.get(context).changeTheme();
                    },
                    text: Theme.of(context).brightness == Brightness.dark
                        ? 'Dark Mode'
                        : 'Light Mode',
                    icon: Theme.of(context).brightness == Brightness.dark
                        ? Icons.dark_mode
                        : Icons.light_mode,
                  ),
                  DrawerItem(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool(isLoggedIn, false);
                      FirebaseAuth.instance.signOut();
                      if (context.mounted) {
                        AppCubit.get(context).loginPageState(0);
                        FirebaseMessaging.instance
                            .unsubscribeFromTopic('notify');
                        FirebaseMessaging.instance
                            .unsubscribeFromTopic(prefs.getString(id)!);
                        FirebaseMessaging.instance
                            .unsubscribeFromTopic('offers');
                        FirebaseMessaging.instance
                            .unsubscribeFromTopic('newUsers');
                        FirebaseMessaging.instance.unsubscribeFromTopic('0');
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(
                          context,
                          LoginPage.id,
                        );
                      }
                    },
                    text: 'Log Out',
                    icon: Icons.logout,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

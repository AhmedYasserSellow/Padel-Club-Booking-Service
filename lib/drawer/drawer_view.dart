import 'package:booking/components/constants.dart';
import 'package:booking/drawer/widgets/change_theme_button.dart';
import 'package:booking/drawer/widgets/log_out.dart';
import 'package:booking/drawer/widgets/main_pages.dart';
import 'package:booking/drawer/widgets/profile_info.dart';
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
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ProfileInfo(
                      name: name,
                      phone: phone,
                      isManager: isManager,
                    ),
                    MainPages(
                      isManager: isManager,
                    ),
                    const ThemeChangerButton(),
                    const LogOut(),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

import 'package:booking/components/constants.dart';
import 'package:booking/layouts/home/drawer/widgets/change_theme_button.dart';
import 'package:booking/components/widgets/log_out.dart';
import 'package:booking/layouts/home/drawer/widgets/main_pages.dart';
import 'package:booking/layouts/home/drawer/widgets/profile_info.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDrawerView extends StatefulWidget {
  const HomeDrawerView({
    super.key,
  });

  @override
  State<HomeDrawerView> createState() => _HomeDrawerViewState();
}

class _HomeDrawerViewState extends State<HomeDrawerView> {
  String name = '';
  String phone = '';
  bool isManager = false;
  String firebaseID = '';
  Future loadState() async {
    final prefs = await SharedPreferences.getInstance();
    isManager = prefs.getBool(dev)!;
    name = prefs.getString(yourName)!;
    phone = prefs.getString(yourPhone)!;
    firebaseID = prefs.getString(id)!;
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
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(12),
                ),
              ),
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
                      firebaseID: firebaseID,
                      isManager: isManager,
                      myName: name,
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

import 'package:booking/core/utilities/constants/constants.dart';
import 'package:booking/core/utilities/services/service_locator.dart';
import 'package:booking/layouts/home/screens/drawer%20screen/widgets/change_theme_button.dart';
import 'package:booking/layouts/home/screens/drawer%20screen/widgets/log_out.dart';
import 'package:booking/layouts/home/screens/drawer%20screen/widgets/main_pages.dart';
import 'package:booking/layouts/home/screens/drawer%20screen/widgets/profile_info.dart';
import 'package:flutter/material.dart';

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
    final prefs = await GetInstance.prefs;
    isManager = prefs.getBool(PrefsKeys.kAdmin)!;
    name = prefs.getString(PrefsKeys.kName)!;
    phone = prefs.getString(PrefsKeys.kPhone)!;
    firebaseID = prefs.getString(PrefsKeys.kFirebaseID)!;
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

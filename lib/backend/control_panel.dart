import 'package:booking/backend/dashboard%20drawer/dashboard_drawer_view.dart';
import 'package:booking/backend/dashboard%20drawer/dashboard_pages.dart';
import 'package:booking/components/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/cubit.dart';
import '../logic/states.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({
    super.key,
  });
  static String id = 'CMD';

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
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
            drawer: DashBoardDrawerView(
              name: args['name'],
              phone: args['phone'],
            ),
            key: scaffoldKey,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                color: textColor,
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                },
              ),
              title: Text(
                'Dashboard',
                style: TextStyle(color: textColor),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: screens[AppCubit.get(context).dashboardPAgesIndex]
                      .mainWidget,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

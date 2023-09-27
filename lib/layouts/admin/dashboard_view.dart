import 'package:booking/core/routes/app_routes.dart';
import 'package:booking/layouts/admin/drawer/dashboard_drawer_view.dart';
import 'package:booking/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit.dart';
import '../../logic/states.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({
    super.key,
  });
  static String id = 'DashBoard';

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
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
                color: whiteTextColor,
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                },
              ),
              title: Text(
                'Dashboard',
                style: TextStyle(color: whiteTextColor),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: AppCubit.get(context).dashboardPagesIndex ==
                    dashboardPages.length - 1
                ? dashboardPages[AppCubit.get(context).dashboardPagesIndex]
                    .mainWidget
                : Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: dashboardPages[
                                AppCubit.get(context).dashboardPagesIndex]
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

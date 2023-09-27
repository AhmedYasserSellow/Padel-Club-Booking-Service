import 'package:booking/core/routes/app_routes.dart';
import 'package:booking/layouts/admin/drawer/dashboard_drawer_view.dart';
import 'package:booking/core/theme/theme.dart';
import 'package:booking/layouts/admin/logic/admin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminView extends StatefulWidget {
  const AdminView({
    super.key,
  });
  static String id = 'Admin';

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return BlocProvider(
      create: (context) => AdminCubit(),
      child: BlocBuilder<AdminCubit, AdminState>(
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
              body: AdminCubit.get(context).dashboardPagesIndex ==
                      dashboardPages.length - 1
                  ? dashboardPages[AdminCubit.get(context).dashboardPagesIndex]
                      .mainWidget
                  : Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: dashboardPages[
                                  AdminCubit.get(context).dashboardPagesIndex]
                              .mainWidget,
                        ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}

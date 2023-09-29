import 'package:booking/core/utilities/routes/app_routes.dart';

import 'package:booking/layouts/admin/screens/drawer%20screen/dashboard_drawer_view.dart';
import 'package:booking/core/utilities/theme/theme.dart';
import 'package:booking/layouts/admin/logic/admin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLayout extends StatelessWidget {
  const AdminLayout({
    super.key,
  });
  static String id = 'Admin';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return Theme(
      data: AppTheme.darkTheme,
      child: BlocProvider(
        create: (context) => AdminCubit(),
        child: BlocBuilder<AdminCubit, AdminState>(
          builder: (context, state) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.racketFirstColor,
                    AppTheme.racketSecondColor,
                  ],
                ),
              ),
              child: Scaffold(
                drawer: DashBoardDrawerView(
                  name: args['name'],
                  phone: args['phone'],
                ),
                key: AdminCubit.get(context).scaffoldKey,
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  systemOverlayStyle: SystemUiOverlayStyle.light,
                  leading: IconButton(
                    icon: const Icon(Icons.menu),
                    color: AppTheme.whiteTextColor,
                    onPressed: () {
                      AdminCubit.get(context)
                          .scaffoldKey
                          .currentState!
                          .openDrawer();
                    },
                  ),
                  title: Text(
                    'Dashboard',
                    style: TextStyle(color: AppTheme.whiteTextColor),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                body: AdminCubit.get(context).dashboardPagesIndex ==
                        dashboardPages.length - 1
                    ? dashboardPages[
                            AdminCubit.get(context).dashboardPagesIndex]
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
      ),
    );
  }
}

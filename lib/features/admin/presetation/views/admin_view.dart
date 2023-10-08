import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/features/admin/presetation/view_model/admin_cubit/admin_cubit.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/admin_view_builder.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/appbar_icon.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/dashboard_pages_navigator.dart';

class AdminView extends StatelessWidget {
  const AdminView({
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
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  systemOverlayStyle: SystemUiOverlayStyle.light,
                  leading: const AppBarIcon(),
                  title: Text(
                    'Dashboard',
                    style: TextStyle(color: AppTheme.whiteTextColor),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                body: AdminCubit.get(context).dashboardPagesIndex == -1
                    ? AdminHomeView(
                        name: args['name'],
                        phone: args['phone'],
                      )
                    : const DashboardPagesNavigator(),
              ),
            );
          },
        ),
      ),
    );
  }
}

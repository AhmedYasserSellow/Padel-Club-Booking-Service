import 'package:booking/core/utilities/constants/constants.dart';
import 'package:booking/core/utilities/routes/app_routes.dart';
import 'package:booking/core/utilities/theme/logic/theme_cubit.dart';
import 'package:booking/layouts/home/screens/drawer%20screen/drawer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'logic/home_cubit.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({
    super.key,
  });
  static String id = 'HomeLayout';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: connection.onStatusChange,
        builder: (context, ethernetSnapshot) {
          return StreamBuilder(
              stream: Stream.fromFuture(connection.connectionStatus),
              builder: (context, internetSnapshot) {
                return BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return Scaffold(
                        key: HomeCubit.get(context).scaffoldKey,
                        drawer: const HomeDrawerView(),
                        appBar: AppBar(
                          scrolledUnderElevation: 0,
                          leading: IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: ThemeCubit.get(context).iconAndTextColor,
                            ),
                            onPressed: () {
                              HomeCubit.get(context)
                                  .scaffoldKey
                                  .currentState!
                                  .openDrawer();
                            },
                          ),
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          toolbarHeight: 56,
                          centerTitle: true,
                          title: Image.asset(
                            ThemeCubit.get(context).isLightMode
                                ? 'assets/logo.png'
                                : 'assets/logodark.png',
                            height: 72,
                          ),
                        ),
                        body: (internetSnapshot.data ==
                                    InternetConnectionStatus.connected ||
                                ethernetSnapshot.data ==
                                    InternetConnectionStatus.connected)
                            ? homePages(
                                firebaseID: HomeCubit.get(context).firebaseID,
                                myName: HomeCubit.get(context).name,
                                manager: HomeCubit.get(context).manager,
                              )[HomeCubit.get(context).mainPagesIndex]
                                .mainWidget
                            : homePages(
                                firebaseID: HomeCubit.get(context).firebaseID,
                                myName: HomeCubit.get(context).name,
                                manager: HomeCubit.get(context).manager,
                              )[HomeCubit.get(context).mainPagesIndex]
                                .shimmerWidget);
                  },
                );
              });
        });
  }
}

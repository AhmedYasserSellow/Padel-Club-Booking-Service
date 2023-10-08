import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/routes/app_routes.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/features/home/presentation/view_models/home_cubit/home_cubit.dart';
import 'package:padel_club/features/splash/presentation/views/splash_view.dart';

void main() async {
  await GetInstance.setupFirebase();
  await GetInstance.registerInstances();
  await GetInstance.intializeNotofications();

  runApp(const PadelClub());
}

class PadelClub extends StatelessWidget {
  const PadelClub({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit()
        ..getAppTheme()
        ..loadState(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Padel Club',
            theme: HomeCubit.get(context).isLightMode
                ? AppTheme.lightTheme
                : AppTheme.darkTheme,
            debugShowCheckedModeBanner: false,
            routes: appRoutes,
            initialRoute: SplashView.id,
          );
        },
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/routes/app_routes.dart';
import 'package:padel_club/core/utilities/services/notifications.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/features/home/presentation/view_models/home_cubit/home_cubit.dart';
import 'package:padel_club/features/splash/presentation/views/splash_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetInstance.setup();
  final prefs = await GetInstance.prefs;
  bool isShowed = prefs.getBool(PrefsKeys.kIsPremessionShowed) ?? false;
  if (isShowed == false) {
    await NotificationService.getPermssion();
    prefs.setBool(PrefsKeys.kIsPremessionShowed, true);
  }

  NotificationService.initNotification();
  runApp(const PadelClub());
}

class PadelClub extends StatelessWidget {
  const PadelClub({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit()
        ..loadState()
        ..getAppTheme(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Padel Club',
            theme: HomeCubit.get(context).isLightMode
                //Light Theme
                ? AppTheme.lightTheme
                //Dark Theme
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

import 'package:booking/layouts/login%20Layout/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/cubit.dart';
import 'bloc/states.dart';

import 'database/control_panel.dart';
import 'firebase_options.dart';
import 'layouts/home_layout.dart';
import 'screens/splash screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return AppCubit();
      },
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: AppCubit.get(context).brightness == Brightness.light
                ? ThemeData.light()
                : ThemeData.dark(),
            debugShowCheckedModeBanner: false,
            routes: {
              Splash.id: (context) => const Splash(),
              HomePage.id: (context) => const HomePage(),
              LoginPage.id: (context) => const LoginPage(),

              // DEV Mode --------------------------------------------------
              ControlPanel.id: (context) => const ControlPanel(),
            },
            initialRoute: Splash.id,
          );
        },
      ),
    );
  }
}

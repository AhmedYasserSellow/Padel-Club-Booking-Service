import 'package:flutter/material.dart';
import 'package:padel_club/features/home/presentation/view_models/home_cubit/home_cubit.dart';
import 'package:padel_club/features/home/presentation/views/widgets/change_theme_button.dart';
import 'package:padel_club/features/home/presentation/views/widgets/log_out.dart';
import 'package:padel_club/features/home/presentation/views/widgets/main_pages.dart';
import 'package:padel_club/features/home/presentation/views/widgets/profile_info.dart';

class HomeDrawerView extends StatelessWidget {
  const HomeDrawerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
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
                name: cubit.name,
                phone: cubit.phone,
                isManager: cubit.manager,
              ),
              MainPages(
                firebaseID: cubit.firebaseID,
                isManager: cubit.manager,
                myName: cubit.name,
              ),
              const ThemeChangerButton(),
              const LogOut(),
            ],
          ),
        ),
      ),
    );
  }
}

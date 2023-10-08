import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/features/admin/presetation/view_model/admin_cubit/admin_cubit.dart';
import 'package:padel_club/features/home/presentation/views/home_view.dart';

class AppBarIcon extends StatelessWidget {
  const AppBarIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(
      builder: (context, state) {
        if (AdminCubit.get(context).dashboardPagesIndex == -1) {
          return IconButton(
            icon: const Icon(Icons.home),
            color: AppTheme.whiteTextColor,
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                HomeView.id,
              );
            },
          );
        } else {
          return IconButton(
              color: AppTheme.whiteTextColor,
              onPressed: () {
                AdminCubit.get(context).navigateToDashboardPages(context, -1);
              },
              icon: const Icon(Icons.arrow_back));
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());
  static AdminCubit get(context) => BlocProvider.of(context);
  int dashboardPagesIndex = 0;
  bool isExpanded = false;
  int monthDB = 1;
  int dayDB = 1;
  int indexDB = 0;

  void navigateToDashboardPages(BuildContext context, int index) {
    dashboardPagesIndex = index;
    Navigator.pop(context);
    emit(ChangeBottomNavIndexForDB());
  }

  void progressCalculator() {
    emit(ProgressCalculator());
  }
}

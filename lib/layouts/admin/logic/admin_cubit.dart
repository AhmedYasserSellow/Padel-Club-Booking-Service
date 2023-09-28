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
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  void navigateToDashboardPages(BuildContext context, int index) {
    dashboardPagesIndex = index;
    scaffoldKey.currentState!.closeDrawer();
    emit(ChangeBottomNavIndexForDB());
  }

  void pagesExpnasionChanger(bool expanded) {
    isExpanded = expanded;
    emit(ChangeExpansion());
  }

  void progressCalculator() {
    emit(ProgressCalculator());
  }
}

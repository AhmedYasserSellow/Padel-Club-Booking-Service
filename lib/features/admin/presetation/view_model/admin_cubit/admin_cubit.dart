import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());
  static AdminCubit get(context) => BlocProvider.of(context);
  int dashboardPagesIndex = 0;
  bool isExpanded = false;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  void navigateToDashboardPages(BuildContext context, int index) {
    dashboardPagesIndex = index;
    scaffoldKey.currentState!.closeDrawer();
    emit(ChangePageIndex());
  }

  void pagesExpnasionChanger(bool expanded) {
    isExpanded = expanded;
    emit(ChangeExpansion());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
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

  Future logOut(BuildContext context) async {
    GetInstance.adminRepoImpl.logOut(context);
  }
}

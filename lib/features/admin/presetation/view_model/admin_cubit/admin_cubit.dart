import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());
  static AdminCubit get(context) => BlocProvider.of(context);
  int dashboardPagesIndex = -1;
  bool isExpanded = false;

  void navigateToDashboardPages(BuildContext context, int index) {
    dashboardPagesIndex = index;
    emit(ChangePageIndex());
  }

  Future logOut(BuildContext context) async {
    GetInstance.adminRepoImpl.logOut(context);
  }
}

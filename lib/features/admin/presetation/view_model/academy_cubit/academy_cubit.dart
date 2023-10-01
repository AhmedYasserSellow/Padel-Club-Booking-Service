import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/extensions/extensions.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/features/admin/data/models/time_model.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/progress_dialog.dart';

part 'academy_state.dart';

class AcademyCubit extends Cubit<AcademyState> {
  AcademyCubit() : super(AcademyInitial());
  static AcademyCubit get(context) => BlocProvider.of(context);
  final TextEditingController academyYear = TextEditingController();
  final TextEditingController academyMonth = TextEditingController();
  final TextEditingController academyStartTime = TextEditingController();
  final TextEditingController academyEndTime = TextEditingController();
  final TextEditingController dayIndex = TextEditingController();
  final GlobalKey<FormState> academyFormKey = GlobalKey<FormState>();

  Future addAcademyTimes(
    BuildContext context,
  ) async {
    GetInstance.adminRepoImpl.addAcademyTimes(
      context,
      TimeModel(
        year: academyYear.text,
        month: academyMonth.text,
        dayName: days[dayIndex.text.toInt()],
        start: academyStartTime.text,
        end: academyEndTime.text,
      ),
    );
    progressDialog(context);
  }

  Future removeAcademyTimes(
    BuildContext context,
  ) async {
    GetInstance.adminRepoImpl.removeAcademyTimes(
      context,
      TimeModel(
        year: academyYear.text,
        month: academyMonth.text,
        dayName: days[dayIndex.text.toInt()],
        start: academyStartTime.text,
        end: academyEndTime.text,
      ),
    );
    progressDialog(context);
  }
}

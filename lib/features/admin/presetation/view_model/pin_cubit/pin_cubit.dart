import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/extensions/extensions.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/features/admin/data/models/time_model.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/progress_dialog.dart';

part 'pin_state.dart';

class PinCubit extends Cubit<PinState> {
  PinCubit() : super(PinInitial());
  static PinCubit get(context) => BlocProvider.of(context);

  final TextEditingController pinYear = TextEditingController();
  final TextEditingController pinMonth = TextEditingController();
  final TextEditingController pinStart = TextEditingController();
  final TextEditingController pinEnd = TextEditingController();
  final TextEditingController dayIndex = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future addPinTimes(BuildContext context) async {
    GetInstance.adminRepoImpl.addPinnedTimes(
      context,
      TimeModel(
        year: pinYear.text,
        month: pinMonth.text,
        dayName: days[dayIndex.text.toInt()],
        start: pinStart.text,
        end: pinEnd.text,
      ),
      name.text,
      phone.text,
    );
    progressDialog(context);
  }

  Future removePinTimes(BuildContext context) async {
    GetInstance.adminRepoImpl.removePinnedTimes(
      context,
      TimeModel(
        year: pinYear.text,
        month: pinMonth.text,
        dayName: days[dayIndex.text.toInt()],
        start: pinStart.text,
        end: pinEnd.text,
      ),
    );
    progressDialog(context);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/features/admin/presetation/view_model/pin_cubit/pin_cubit.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/buttons_row.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/days.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/pin_user_info.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/start_end_times_text_field.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/year_month_text_field.dart';

class PinTimes extends StatelessWidget {
  const PinTimes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PinCubit(),
      child: BlocBuilder<PinCubit, PinState>(builder: (context, state) {
        PinCubit cubit = PinCubit.get(context);
        return Form(
          key: cubit.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const UserInfo(),
              YearAndMonthTextFields(
                yearController: cubit.pinYear,
                monthController: cubit.pinMonth,
                title: 'Pinning Time',
              ),
              StartAndEndTextFields(
                title: 'Pinnig Time 24H Format',
                dayIndexController: cubit.dayIndex,
                startTimeController: cubit.pinStart,
                endTimeController: cubit.pinEnd,
              ),
              const DaysIndex(),
              ButtonsRow(
                firstButtonTitle: 'Pin',
                secondButtonTitle: 'Unpin',
                firstButtonOnTap: () {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.addPinTimes(context);
                  }
                },
                secondButtonOnTap: () {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.removePinTimes(context);
                  }
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}

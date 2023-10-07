import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/features/admin/presetation/view_model/academy_cubit/academy_cubit.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/buttons_row.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/days.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/start_end_times_text_field.dart';
import 'package:padel_club/features/admin/presetation/views/widgets/year_month_text_field.dart';

class ControlAcademy extends StatelessWidget {
  const ControlAcademy({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AcademyCubit(),
      child: BlocBuilder<AcademyCubit, AcademyState>(builder: (context, state) {
        AcademyCubit cubit = AcademyCubit.get(context);
        return Form(
          key: cubit.academyFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              YearAndMonthTextFields(
                yearController: cubit.academyYear,
                monthController: cubit.academyMonth,
                title: 'Academy',
              ),
              StartAndEndTextFields(
                title: 'Academy Time 24H Format',
                dayIndexController: cubit.dayIndex,
                startTimeController: cubit.academyStartTime,
                endTimeController: cubit.academyEndTime,
              ),
              const DaysIndex(),
              ButtonsRow(
                firstButtonTitle: 'Add Selected Day',
                secondButtonTitle: 'Remove Selected Day',
                firstButtonOnTap: () {
                  if (cubit.academyFormKey.currentState!.validate()) {
                    cubit.addAcademyTimes(context);
                  }
                },
                secondButtonOnTap: () {
                  if (cubit.academyFormKey.currentState!.validate()) {
                    cubit.removeAcademyTimes(context);
                  }
                },
              )
            ],
          ),
        );
      }),
    );
  }
}

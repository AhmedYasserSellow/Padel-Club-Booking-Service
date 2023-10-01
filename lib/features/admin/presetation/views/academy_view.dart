import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/core/widgets/default_button.dart';
import 'package:padel_club/core/widgets/text_form_field.dart';
import 'package:padel_club/features/admin/presetation/view_model/academy_cubit/academy_cubit.dart';

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
              Text(
                'Academy',
                style: TextStyle(color: AppTheme.whiteTextColor),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: myTextFormField(
                      controller: cubit.academyYear,
                      type: TextInputType.number,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'year is required';
                        }
                        if (value.length != 4) {
                          return 'enter a valid year';
                        }
                        return null;
                      },
                      label: 'Year',
                      prefix: Icons.numbers,
                      context: context,
                      color: AppTheme.whiteTextColor,
                      textStyleColor: AppTheme.whiteTextColor,
                      labelColor: AppTheme.whiteTextColor,
                      focusColor: AppTheme.whiteTextColor,
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: myTextFormField(
                      controller: cubit.academyMonth,
                      type: TextInputType.number,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'month is required';
                        }
                        if (int.tryParse(value)! > 12) {
                          return 'enter a valid month';
                        }
                        return null;
                      },
                      label: 'Month',
                      prefix: Icons.numbers,
                      context: context,
                      color: AppTheme.whiteTextColor,
                      textStyleColor: AppTheme.whiteTextColor,
                      labelColor: AppTheme.whiteTextColor,
                      focusColor: AppTheme.whiteTextColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Academy Time 24H Format',
                style: TextStyle(color: AppTheme.whiteTextColor),
              ),
              const SizedBox(
                height: 12,
              ),
              myTextFormField(
                controller: cubit.dayIndex,
                type: TextInputType.number,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return 'day index is required';
                  }

                  if (int.tryParse(value)! > 7) {
                    return 'enter a valid day number';
                  }
                  return null;
                },
                label: 'Day Number',
                prefix: Icons.numbers,
                context: context,
                color: AppTheme.whiteTextColor,
                textStyleColor: AppTheme.whiteTextColor,
                labelColor: AppTheme.whiteTextColor,
                focusColor: AppTheme.whiteTextColor,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: myTextFormField(
                      controller: cubit.academyStartTime,
                      type: TextInputType.number,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'ending time is required';
                        }

                        if (int.tryParse(value)! > 23) {
                          return 'enter a valid starting time';
                        }
                        return null;
                      },
                      label: 'From',
                      prefix: Icons.numbers,
                      context: context,
                      color: AppTheme.whiteTextColor,
                      textStyleColor: AppTheme.whiteTextColor,
                      labelColor: AppTheme.whiteTextColor,
                      focusColor: AppTheme.whiteTextColor,
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: myTextFormField(
                      controller: cubit.academyEndTime,
                      type: TextInputType.number,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'ending time is required';
                        }
                        if (int.tryParse(value)! == 0) {
                          return 'please enter 24 instead';
                        }
                        if (int.tryParse(value)! > 23 &&
                            int.tryParse(value) != 24) {
                          return 'enter a valid starting time';
                        }
                        return null;
                      },
                      label: 'To',
                      prefix: Icons.numbers,
                      context: context,
                      color: AppTheme.whiteTextColor,
                      textStyleColor: AppTheme.whiteTextColor,
                      labelColor: AppTheme.whiteTextColor,
                      focusColor: AppTheme.whiteTextColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '1 : ${days[0]}',
                    style: TextStyle(color: AppTheme.whiteTextColor),
                  ),
                  Text(
                    '2 : ${days[1]}',
                    style: TextStyle(color: AppTheme.whiteTextColor),
                  ),
                  Text(
                    '3 : ${days[2]}',
                    style: TextStyle(color: AppTheme.whiteTextColor),
                  ),
                  Text(
                    '4 : ${days[3]}',
                    style: TextStyle(color: AppTheme.whiteTextColor),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '5 : ${days[4]}',
                    style: TextStyle(color: AppTheme.whiteTextColor),
                  ),
                  Text(
                    '6 : ${days[5]}',
                    style: TextStyle(color: AppTheme.whiteTextColor),
                  ),
                  Text(
                    '7 : ${days[6]}',
                    style: TextStyle(color: AppTheme.whiteTextColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: defaultButton(
                      color: AppTheme.availableColor,
                      onTap: () {
                        if (cubit.academyFormKey.currentState!.validate()) {
                          cubit.addAcademyTimes(context);
                        }
                      },
                      text: 'Add Selected Day',
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: defaultButton(
                      color: AppTheme.bookedColor,
                      onTap: () {
                        if (cubit.academyFormKey.currentState!.validate()) {
                          cubit.removeAcademyTimes(context);
                        }
                      },
                      text: 'Remove Selected Day',
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}

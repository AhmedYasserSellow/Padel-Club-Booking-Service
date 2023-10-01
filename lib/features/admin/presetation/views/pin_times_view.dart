import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/core/widgets/default_button.dart';
import 'package:padel_club/core/widgets/text_form_field.dart';
import 'package:padel_club/features/admin/presetation/view_model/pin_cubit/pin_cubit.dart';

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
              Text(
                'User Info',
                style: TextStyle(color: AppTheme.whiteTextColor),
              ),
              const SizedBox(
                height: 12,
              ),
              myTextFormField(
                controller: cubit.name,
                type: TextInputType.name,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return 'name is required';
                  }
                  return null;
                },
                label: 'Name',
                prefix: Icons.title,
                context: context,
                color: AppTheme.whiteTextColor,
                textStyleColor: AppTheme.whiteTextColor,
                labelColor: AppTheme.whiteTextColor,
                focusColor: AppTheme.whiteTextColor,
              ),
              const SizedBox(
                height: 12,
              ),
              myTextFormField(
                limit: 11,
                controller: cubit.phone,
                type: TextInputType.phone,
                validate: (String? value) {
                  if (value!.isEmpty) {
                    return 'phone number is required';
                  }
                  if (!value.startsWith('01') || value.length != 11) {
                    return 'enter a valid phone number';
                  }
                  return null;
                },
                label: 'Phone Number',
                prefix: Icons.phone,
                context: context,
                color: AppTheme.whiteTextColor,
                textStyleColor: AppTheme.whiteTextColor,
                labelColor: AppTheme.whiteTextColor,
                focusColor: AppTheme.whiteTextColor,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Pinning Time',
                style: TextStyle(color: AppTheme.whiteTextColor),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: myTextFormField(
                      limit: 4,
                      controller: cubit.pinYear,
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
                      limit: 2,
                      controller: cubit.pinMonth,
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
                'Pinning Time 24H Format',
                style: TextStyle(
                  color: AppTheme.whiteTextColor,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              myTextFormField(
                limit: 1,
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
                      limit: 2,
                      controller: cubit.pinStart,
                      type: TextInputType.number,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'starting time is required';
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
                      limit: 2,
                      controller: cubit.pinEnd,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: defaultButton(
                      text: 'Pin',
                      onTap: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.addPinTimes(context);
                        }
                      },
                      color: AppTheme.availableColor,
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Expanded(
                    child: defaultButton(
                      color: AppTheme.bookedColor,
                      onTap: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.removePinTimes(context);
                        }
                      },
                      text: 'Unpin',
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

import 'package:booking/components/constants/constants.dart';
import 'package:booking/components/widgets/default_button.dart';
import 'package:booking/layouts/admin/functions/academy_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/cubit.dart';
import '../../../logic/states.dart';
import '../../../components/theme/theme.dart';
import '../../../components/widgets/text_form_field.dart';
import '../../home/dialogs/progress_dialog.dart';

class ControlAcademy extends StatelessWidget {
  ControlAcademy({super.key});
  final TextEditingController yeasAcademy = TextEditingController();
  final TextEditingController monthAcademy = TextEditingController();
  final TextEditingController fromAcademy = TextEditingController();
  final TextEditingController toAcademy = TextEditingController();
  final TextEditingController dayIndex = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
      return Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Academy',
              style: TextStyle(color: whiteTextColor),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: myTextFormField(
                    controller: yeasAcademy,
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
                    color: whiteTextColor,
                    textStyleColor: whiteTextColor,
                    labelColor: whiteTextColor,
                    focusColor: whiteTextColor,
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: myTextFormField(
                    controller: monthAcademy,
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
                    color: whiteTextColor,
                    textStyleColor: whiteTextColor,
                    labelColor: whiteTextColor,
                    focusColor: whiteTextColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Academy Time 24H Format',
              style: TextStyle(color: whiteTextColor),
            ),
            const SizedBox(
              height: 12,
            ),
            myTextFormField(
              controller: dayIndex,
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
              color: whiteTextColor,
              textStyleColor: whiteTextColor,
              labelColor: whiteTextColor,
              focusColor: whiteTextColor,
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: myTextFormField(
                    controller: fromAcademy,
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
                    color: whiteTextColor,
                    textStyleColor: whiteTextColor,
                    labelColor: whiteTextColor,
                    focusColor: whiteTextColor,
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: myTextFormField(
                    controller: toAcademy,
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
                    color: whiteTextColor,
                    textStyleColor: whiteTextColor,
                    labelColor: whiteTextColor,
                    focusColor: whiteTextColor,
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
                  style: TextStyle(color: whiteTextColor),
                ),
                Text(
                  '2 : ${days[1]}',
                  style: TextStyle(color: whiteTextColor),
                ),
                Text(
                  '3 : ${days[2]}',
                  style: TextStyle(color: whiteTextColor),
                ),
                Text(
                  '4 : ${days[3]}',
                  style: TextStyle(color: whiteTextColor),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '5 : ${days[4]}',
                  style: TextStyle(color: whiteTextColor),
                ),
                Text(
                  '6 : ${days[5]}',
                  style: TextStyle(color: whiteTextColor),
                ),
                Text(
                  '7 : ${days[6]}',
                  style: TextStyle(color: whiteTextColor),
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
                    color: availableColor,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        addAcdemy(
                            int.tryParse(yeasAcademy.text)!,
                            int.tryParse(monthAcademy.text)!,
                            int.tryParse(fromAcademy.text)!,
                            int.tryParse(toAcademy.text)!,
                            days[int.tryParse(dayIndex.text)! - 1],
                            context);
                        progressDialog(context);
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
                    color: bookedColor,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        removeAcdemy(
                            int.tryParse(yeasAcademy.text)!,
                            int.tryParse(monthAcademy.text)!,
                            int.tryParse(fromAcademy.text)!,
                            int.tryParse(toAcademy.text)!,
                            days[int.tryParse(dayIndex.text)! - 1],
                            context);
                        progressDialog(context);
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
    });
  }
}

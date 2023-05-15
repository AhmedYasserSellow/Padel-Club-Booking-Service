import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/cubit.dart';
import '../../bloc/states.dart';
import '../../components/theme.dart';
import '../../components/widgets/text_form_field.dart';
import '../../dialogs/progress_dialog.dart';
import '../db.dart';

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
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Academy'),
                const SizedBox(
                  height: 12,
                ),
                myTextFormField(
                  limit: 4,
                  controller: yeasAcademy,
                  type: TextInputType.phone,
                  validate: (String? value) {
                    if (value!.isEmpty) {
                      return 'year is required';
                    }
                    if (value.length != 4) {
                      return 'enter a valid year';
                    }
                    return null;
                  },
                  label: 'Years',
                  prefix: Icons.numbers,
                  context: context,
                  color: AppCubit.get(context).iconAndTextColor,
                  textStyleColor: AppCubit.get(context).iconAndTextColor,
                ),
                const SizedBox(
                  height: 12,
                ),
                myTextFormField(
                  limit: 2,
                  controller: monthAcademy,
                  type: TextInputType.phone,
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
                  color: AppCubit.get(context).iconAndTextColor,
                  textStyleColor: AppCubit.get(context).iconAndTextColor,
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text('Academy Time 24H Format'),
                const SizedBox(
                  height: 12,
                ),
                myTextFormField(
                  limit: 2,
                  controller: fromAcademy,
                  type: TextInputType.phone,
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
                  color: AppCubit.get(context).iconAndTextColor,
                  textStyleColor: AppCubit.get(context).iconAndTextColor,
                ),
                const SizedBox(
                  height: 12,
                ),
                myTextFormField(
                  limit: 2,
                  controller: toAcademy,
                  type: TextInputType.phone,
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
                  color: AppCubit.get(context).iconAndTextColor,
                  textStyleColor: AppCubit.get(context).iconAndTextColor,
                ),
                const SizedBox(
                  height: 12,
                ),
                myTextFormField(
                  limit: 1,
                  controller: dayIndex,
                  type: TextInputType.phone,
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
                  color: AppCubit.get(context).iconAndTextColor,
                  textStyleColor: AppCubit.get(context).iconAndTextColor,
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('1 : ${days[0]}'),
                    Text('2 : ${days[1]}'),
                    Text('3 : ${days[2]}'),
                    Text('4 : ${days[3]}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('5 : ${days[4]}'),
                    Text('6 : ${days[5]}'),
                    Text('7 : ${days[6]}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: availableColor),
                      onPressed: () {
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
                      child: const Text('Add Selected Day'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: bookedColor),
                      onPressed: () {
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
                      child: const Text('Remove Selected Day'),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

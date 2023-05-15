import 'package:booking/components/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/cubit.dart';
import '../../bloc/states.dart';
import '../../components/theme.dart';
import '../../components/widgets/text_form_field.dart';
import '../../dialogs/progress_dialog.dart';
import '../db.dart';

class PinTimes extends StatelessWidget {
  PinTimes({super.key});
  final TextEditingController yearsForPin = TextEditingController();
  final TextEditingController monthForPin = TextEditingController();
  final TextEditingController startPin = TextEditingController();
  final TextEditingController endPin = TextEditingController();
  final TextEditingController dayIndex = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
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
                const Text('User Info'),
                const SizedBox(
                  height: 12,
                ),
                myTextFormField(
                  controller: name,
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
                  color: AppCubit.get(context).iconAndTextColor,
                  textStyleColor: AppCubit.get(context).iconAndTextColor,
                ),
                const SizedBox(
                  height: 12,
                ),
                myTextFormField(
                  limit: 11,
                  controller: phone,
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
                  color: AppCubit.get(context).iconAndTextColor,
                  textStyleColor: AppCubit.get(context).iconAndTextColor,
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text('Pinning Time'),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Expanded(
                      child: myTextFormField(
                        limit: 4,
                        controller: yearsForPin,
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
                        label: 'Year',
                        prefix: Icons.numbers,
                        context: context,
                        color: AppCubit.get(context).iconAndTextColor,
                        textStyleColor: AppCubit.get(context).iconAndTextColor,
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: myTextFormField(
                        limit: 2,
                        controller: monthForPin,
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
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text('Pinning Time 24H Format'),
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
                  children: [
                    Expanded(
                      child: myTextFormField(
                        limit: 2,
                        controller: startPin,
                        type: TextInputType.phone,
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
                        color: AppCubit.get(context).iconAndTextColor,
                        textStyleColor: AppCubit.get(context).iconAndTextColor,
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: myTextFormField(
                        limit: 2,
                        controller: endPin,
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
                    ),
                  ],
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
                          if (formKey.currentState!.validate()) {
                            addPin(
                                int.tryParse(yearsForPin.text)!,
                                int.tryParse(monthForPin.text)!,
                                int.tryParse(startPin.text)!,
                                int.tryParse(endPin.text)!,
                                days[int.tryParse(dayIndex.text)! - 1],
                                name.text,
                                phone.text,
                                context);
                            progressDialog(context);
                          }
                        },
                        color: availableColor,
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
                            removePin(
                                int.tryParse(yearsForPin.text)!,
                                int.tryParse(monthForPin.text)!,
                                int.tryParse(startPin.text)!,
                                int.tryParse(endPin.text)!,
                                days[int.tryParse(dayIndex.text)! - 1],
                                name.text,
                                phone.text,
                                context);
                            progressDialog(context);
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
        });
  }
}

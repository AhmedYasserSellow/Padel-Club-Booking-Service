import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cubit.dart';
import '../../bloc/states.dart';
import '../../components/widgets/text_form_field.dart';
import '../db.dart';

class AddYearsToDB extends StatelessWidget {
  AddYearsToDB({super.key});
  final TextEditingController yearDBField = TextEditingController();
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
                const Text('Year'),
                const SizedBox(
                  height: 12,
                ),
                myTextFormField(
                  limit: 4,
                  controller: yearDBField,
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
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        createDatabase(yearDBField.text, context);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text('Adding'),
                                  Text(
                                      'Month : ${AppCubit.get(context).monthDB}.....'),
                                  Text(
                                      'Day : ${AppCubit.get(context).dayDB}....')
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: const Text('Add to Database')),
              ],
            ),
          );
        });
  }
}

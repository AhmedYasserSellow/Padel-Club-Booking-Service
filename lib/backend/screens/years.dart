import 'package:booking/components/theme.dart';
import 'package:booking/components/widgets/default_button.dart';
import 'package:booking/components/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit.dart';
import '../../logic/states.dart';
import '../db.dart';

class AddYearsToDB extends StatelessWidget {
  AddYearsToDB({super.key});
  final TextEditingController yearDBField = TextEditingController();
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
              'Year',
              style: TextStyle(color: textColor),
            ),
            const SizedBox(
              height: 12,
            ),
            myTextFormField(
              limit: 4,
              controller: yearDBField,
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
              color: textColor,
              textStyleColor: textColor,
              focusColor: textColor,
              labelColor: textColor,
            ),
            const SizedBox(
              height: 12,
            ),
            defaultButton(
              text: 'Add to Database',
              color: racketFirstColor,
              onTap: () {
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
                            Text('Day : ${AppCubit.get(context).dayDB}....')
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            )
          ],
        ),
      );
    });
  }
}

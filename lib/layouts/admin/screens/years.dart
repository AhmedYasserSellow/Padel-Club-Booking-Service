import 'package:booking/core/utilities/theme/theme.dart';
import 'package:booking/core/widgets/default_button.dart';
import 'package:booking/core/widgets/text_form_field.dart';
import 'package:booking/layouts/admin/logic/admin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../functions/create_database_functions.dart';

class AddYearsToDB extends StatelessWidget {
  AddYearsToDB({super.key});
  final TextEditingController yearDBField = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCubit, AdminState>(builder: (context, state) {
      return Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Year',
              style: TextStyle(color: AppTheme.whiteTextColor),
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
              color: AppTheme.whiteTextColor,
              textStyleColor: AppTheme.whiteTextColor,
              focusColor: AppTheme.whiteTextColor,
              labelColor: AppTheme.whiteTextColor,
            ),
            const SizedBox(
              height: 12,
            ),
            defaultButton(
              text: 'Add to Database',
              color: AppTheme.racketFirstColor,
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
                                'Month : ${AdminCubit.get(context).monthDB}.....'),
                            Text('Day : ${AdminCubit.get(context).dayDB}....')
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

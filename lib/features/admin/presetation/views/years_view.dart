import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/core/widgets/default_button.dart';
import 'package:padel_club/core/widgets/text_form_field.dart';
import 'package:padel_club/features/admin/presetation/view_model/database_years_cubit/database_years_cubit.dart';

class AddYearsToDB extends StatelessWidget {
  const AddYearsToDB({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DatabaseYearsCubit(),
      child: BlocBuilder<DatabaseYearsCubit, DatabaseYearsState>(
        builder: (context, state) {
          DatabaseYearsCubit cubit = DatabaseYearsCubit.get(context);
          return Form(
            key: cubit.formKey,
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
                  controller: cubit.databaseYear,
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
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.addYear(context);
                    }
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

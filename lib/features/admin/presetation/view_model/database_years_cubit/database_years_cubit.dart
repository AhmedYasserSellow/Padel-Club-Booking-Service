import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';

part 'database_years_state.dart';

class DatabaseYearsCubit extends Cubit<DatabaseYearsState> {
  DatabaseYearsCubit() : super(DatabaseYearsInitial());

  static DatabaseYearsCubit get(context) => BlocProvider.of(context);

  final TextEditingController databaseYear = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int monthDB = 1;
  int dayDB = 1;
  int indexDB = 0;
  Future addYear(BuildContext context) async {
    GetInstance.adminRepoImpl.addNewYearToDatabase(context, databaseYear.text);
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
              Text('Month : $monthDB.....'),
              Text('Day : $dayDB....')
            ],
          ),
        );
      },
    );
  }

  void progressCalculator() {
    emit(ProgressCalculator());
  }
}

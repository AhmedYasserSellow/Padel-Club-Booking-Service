part of 'time_button_model.dart';

class FireBaseModel {
  final String selectedYear;
  final String selectedDay;
  final String selectedMonth;
  final DateTime today;
  final AsyncSnapshot snapshot;
  final String firebaseID;

  FireBaseModel(
      {required this.selectedYear,
      required this.selectedDay,
      required this.selectedMonth,
      required this.today,
      required this.snapshot,
      required this.firebaseID});
}

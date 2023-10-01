part of 'booking_service_model.dart';

class FirebaseModel {
  final String selectedYear;
  final String selectedDay;
  final String selectedMonth;
  final DateTime today;
  final AsyncSnapshot snapshot;
  final String firebaseID;

  FirebaseModel({
    required this.selectedYear,
    required this.selectedDay,
    required this.selectedMonth,
    required this.today,
    required this.snapshot,
    required this.firebaseID,
  });
}

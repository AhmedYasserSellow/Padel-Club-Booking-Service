import 'package:booking/bloc/cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../dialogs/booking_state_dialog.dart';
import '../../dialogs/new_booking_dialog.dart';
import '../constants.dart';
import '../theme.dart';

class BookingTimeButton extends StatelessWidget {
  const BookingTimeButton({
    super.key,
    required this.index,
    required this.focusedDay,
    required this.buttonColor,
    required this.selectedYear,
    required this.selectedDay,
    required this.selectedMonth,
    required this.state,
    required this.name,
    required this.phonenumber,
    required this.snapshot,
  });

  final int? index;
  final DateTime focusedDay;
  final Color? buttonColor;
  final String selectedDay;
  final String selectedMonth;
  final String selectedYear;
  final String state;
  final String name;
  final String phonenumber;
  final AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (state == pending || state == booked) {
          pendingDialog(context, index!, selectedYear, selectedMonth,
              selectedDay, name, phonenumber, state);
        } else if (state == academy) {
        } else {
          if (DateTime.utc(2023, 5, 5)
              .isBefore(AppCubit.get(context).focusedDay)) {
            bookingDialog(
              context,
              index!,
              selectedYear,
              selectedMonth,
              selectedDay,
              snapshot,
            );
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 40,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            clock[index!],
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: textColor),
          ),
        ),
      ),
    );
  }
}

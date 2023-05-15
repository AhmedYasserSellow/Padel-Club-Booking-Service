import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../components/constants.dart';
import '../../components/theme.dart';
import '../../components/widgets/time_button.dart';

class ButtonsList extends StatelessWidget {
  const ButtonsList({
    super.key,
    required this.selectedYear,
    required this.selectedDay,
    required this.selectedMonth,
    required this.today,
    required this.snapshot,
  });

  final String selectedYear;
  final String selectedDay;
  final String selectedMonth;
  final DateTime today;
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('Control Panel')
            .doc('Prices')
            .get(),
        builder: (context, pricesSnapshot) {
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              Color? buttonColor;
              String state;

              state = snapshot.data!.docs[index]['State'];
              if (snapshot.data!.docs[index]['State'] == pending) {
                buttonColor = pendingColor;
              } else if (snapshot.data!.docs[index]['State'] == booked) {
                buttonColor = bookedColor;
              } else if (snapshot.data!.docs[index]['State'] == academy) {
                buttonColor = academyColor;
              } else {
                buttonColor = availableColor;
              }

              return BookingTimeButton(
                name: snapshot.data!.docs[index]['Name'],
                phonenumber: snapshot.data!.docs[index]['Phone'],
                state: state,
                selectedYear: selectedYear,
                selectedDay: selectedDay,
                selectedMonth: selectedMonth,
                buttonColor: buttonColor,
                focusedDay: today,
                index: index,
                snapshot: pricesSnapshot,
              );
            },
            itemCount: 24,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 12,
              );
            },
          );
        });
  }
}

class BookingStates extends StatelessWidget {
  const BookingStates({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 8,
        ),
        stateColor(availableColor, 'Available'),
        stateColor(pendingColor, pending),
        stateColor(bookedColor, booked),
        stateColor(academyColor, academy)
      ],
    );
  }
}

Widget stateColor(Color color, String state) {
  return Row(
    children: [
      Container(
        color: color,
        height: 16,
        width: 16,
      ),
      const SizedBox(
        width: 4,
      ),
      Text(state),
      const SizedBox(
        width: 8,
      ),
    ],
  );
}

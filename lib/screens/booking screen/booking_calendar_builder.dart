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
          return SliverList.separated(
            itemBuilder: (BuildContext context, int index) {
              Color? buttonColor;
              String name = snapshot.data!.docs[index]['Name'];
              String phone = snapshot.data!.docs[index]['Phone'];
              String state = snapshot.data!.docs[index]['State'];
              if (state == pending) {
                buttonColor = pendingColor;
              } else if (state == booked) {
                buttonColor = bookedColor;
              } else if (state == academy) {
                buttonColor = academyColor;
              } else {
                buttonColor = availableColor;
              }

              return Column(
                children: [
                  BookingTimeButton(
                    name: name,
                    phonenumber: phone,
                    state: state,
                    selectedYear: selectedYear,
                    selectedDay: selectedDay,
                    selectedMonth: selectedMonth,
                    buttonColor: buttonColor,
                    focusedDay: today,
                    index: index,
                    price: pricesSnapshot,
                  ),
                  index == 23
                      ? const SizedBox(
                          height: 12,
                        )
                      : const SizedBox()
                ],
              );
            },
            itemCount: 24,
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

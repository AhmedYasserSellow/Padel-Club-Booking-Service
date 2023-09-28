import 'package:booking/core/utilities/constants/constants.dart';
import 'package:booking/core/utilities/theme/theme.dart';
import 'package:flutter/material.dart';

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

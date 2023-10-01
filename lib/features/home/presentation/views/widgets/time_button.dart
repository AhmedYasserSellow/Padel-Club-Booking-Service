import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/features/home/data/models/booking_service_model.dart';
import 'package:padel_club/features/home/presentation/views/widgets/booking_state_dialog.dart';
import 'package:padel_club/features/home/presentation/views/widgets/new_booking_dialog.dart';

class BookingTimeButton extends StatelessWidget {
  const BookingTimeButton({
    super.key,
    required this.bookingServiceModel,
  });
  final BookingServiceModel bookingServiceModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (bookingServiceModel.state == pending ||
            bookingServiceModel.state == booked) {
          pendingDialog(
            context,
            bookingServiceModel,
          );
        } else if (bookingServiceModel.state == academy) {
        } else {
          bookingDialog(
            context,
            bookingServiceModel,
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 40,
        decoration: BoxDecoration(
          color: bookingServiceModel.buttonColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            clock[bookingServiceModel.index],
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppTheme.whiteTextColor),
          ),
        ),
      ),
    );
  }
}

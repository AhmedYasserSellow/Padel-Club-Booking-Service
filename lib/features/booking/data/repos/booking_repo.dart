import 'package:flutter/material.dart';
import 'package:padel_club/features/booking/data/models/booking_service_model.dart';

abstract class BookingRepo {
  Future confirmBooking(
      BuildContext context, BookingServiceModel bookingServiceModel);
  Future cancelBooking(
      BuildContext context, BookingServiceModel bookingServiceModel);
  Future addNewBook(
      BuildContext context,
      BookingServiceModel bookingServiceModel,
      bool manager,
      TextEditingController nameController,
      TextEditingController phoneNumberController,
      String myID);
}

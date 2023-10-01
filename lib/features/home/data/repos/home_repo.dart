import 'package:flutter/material.dart';
import 'package:padel_club/features/home/data/models/booking_service_model.dart';

abstract class HomeRepo {
  Future logOut(BuildContext context);
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

  Future updateProfile(
    BuildContext context,
    TextEditingController profileNameController,
    TextEditingController profilePhoneController,
  );

  Future sendMessage(
    TextEditingController controller,
    bool manager,
    String id,
    ScrollController listController,
  );
}

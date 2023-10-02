import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/features/booking/data/models/booking_service_model.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());

  static BookingCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  DateTime focusedDay = DateTime.now();
  DateTime today = DateTime.now();
  int finalYear = DateTime.now().year + 1;

  Future confirmBooking(
      BuildContext context, BookingServiceModel bookingServiceModel) async {
    GetInstance.bookingRepoImpl.confirmBooking(context, bookingServiceModel);
  }

  Future cancelBooking(
      BuildContext context, BookingServiceModel bookingServiceModel) async {
    GetInstance.bookingRepoImpl.cancelBooking(context, bookingServiceModel);
  }

  Future addBooking(BuildContext context,
      BookingServiceModel bookingServiceModel, bool manager, myID) async {
    GetInstance.bookingRepoImpl.addNewBook(context, bookingServiceModel,
        manager, nameController, phoneNumberController, myID);
  }

  void changeSelectedDay(DateTime day) {
    focusedDay = day;
    emit(DayChanged());
  }
}

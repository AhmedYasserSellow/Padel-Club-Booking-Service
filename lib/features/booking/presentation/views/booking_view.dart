import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/core/widgets/loading_indicator.dart';
import 'package:padel_club/features/booking/data/models/booking_service_model.dart';
import 'package:padel_club/features/booking/presentation/view_models/booking_cubit/booking_cubit.dart';
import 'package:padel_club/features/booking/presentation/views/widgets/booking_calendar.dart';
import 'package:padel_club/features/booking/presentation/views/widgets/booking_list.dart';
import 'package:padel_club/features/booking/presentation/views/widgets/booking_states.dart';

class BookingView extends StatelessWidget {
  const BookingView({
    super.key,
    required this.firebaseID,
  });
  final String firebaseID;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingCubit(),
      child: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          BookingCubit cubit = BookingCubit.get(context);
          String selectedYear = cubit.focusedDay.year.toString();
          String selectedMonth = cubit.focusedDay.month.toString();
          String selectedDay = cubit.focusedDay.day.toString();
          return StreamBuilder(
              stream: GetInstance.store
                  .collection(selectedYear)
                  .doc(selectedMonth)
                  .collection(selectedDay)
                  .snapshots(),
              builder: (context, dataBasesnapshot) {
                if (dataBasesnapshot.hasData) {
                  return Column(
                    children: [
                      BookingCalendar(bookingCubit: cubit),
                      const BookingStates(),
                      const SizedBox(
                        height: 12,
                      ),
                      ButtonsList(
                        firebaseModel: FirebaseModel(
                          firebaseID: firebaseID,
                          selectedYear: selectedYear,
                          selectedDay: selectedDay,
                          selectedMonth: selectedMonth,
                          today: cubit.focusedDay,
                          snapshot: dataBasesnapshot,
                        ),
                      ),
                    ],
                  );
                } else {
                  return const LoadingIndicator();
                }
              });
        },
      ),
    );
  }
}

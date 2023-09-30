import 'package:booking/core/utilities/services/service_locator.dart';
import 'package:booking/core/widgets/loading_indicator.dart';
import 'package:booking/layouts/home/models/booking_service_model.dart';
import 'package:booking/layouts/home/screens/booking%20screen/widgets/booking_calendar.dart';
import 'package:booking/layouts/home/screens/booking%20screen/widgets/booking_list.dart';
import 'package:booking/layouts/home/screens/booking%20screen/widgets/booking_states.dart';
import 'package:flutter/material.dart';
import '../../logic/home_cubit.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({
    super.key,
    required this.firebaseID,
  });
  final String firebaseID;
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
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
                BookingCalendar(homeCubit: cubit),
                const BookingStates(),
                const SizedBox(
                  height: 12,
                ),
                ButtonsList(
                  fireBaseModel: FireBaseModel(
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
  }
}

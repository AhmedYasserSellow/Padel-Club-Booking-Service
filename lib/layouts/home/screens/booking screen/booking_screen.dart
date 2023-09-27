import 'package:booking/core/constants/constants.dart';
import 'package:booking/core/theme/logic/theme_cubit.dart';
import 'package:booking/layouts/home/screens/booking%20screen/booking_calendar_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../logic/home_cubit.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({
    super.key,
    required this.firebaseID,
  });
  final String firebaseID;
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    String selectedYear = cubit.focusedDay.year.toString();
    String selectedMonth = cubit.focusedDay.month.toString();
    String selectedDay = cubit.focusedDay.day.toString();

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(selectedYear)
            .doc(selectedMonth)
            .collection(selectedDay)
            .snapshots(),
        builder: (context, dataBasesnapshot) {
          if (dataBasesnapshot.hasData) {
            return Column(
              children: [
                TableCalendar(
                  rowHeight: 52,
                  weekendDays: const [],
                  locale: 'en_US',
                  startingDayOfWeek: StartingDayOfWeek.saturday,
                  calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: ThemeCubit.get(context).isLightMode
                            ? Theme.of(context).indicatorColor.withOpacity(0.5)
                            : Theme.of(context).indicatorColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: ThemeCubit.get(context).isLightMode
                            ? Theme.of(context).indicatorColor
                            : Theme.of(context).indicatorColor.withOpacity(0.5),
                        shape: BoxShape.circle,
                      )),
                  focusedDay: cubit.focusedDay,
                  firstDay: DateTime.utc(2023, 9, 24),
                  lastDay: DateTime.utc(
                    finalYear,
                    cubit.today.month,
                    cubit.today.day,
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  availableGestures: AvailableGestures.all,
                  onDaySelected: (day, focusedDay) {
                    setState(() {
                      cubit.focusedDay = day;
                    });
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(day, cubit.focusedDay);
                  },
                ),
                const BookingStates(),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: ButtonsList(
                    firebaseID: widget.firebaseID,
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
            return Center(
                child: CircularProgressIndicator(
              color: Theme.of(context).indicatorColor,
            ));
          }
        });
  }
}

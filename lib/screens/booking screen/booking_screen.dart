import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../bloc/cubit.dart';
import '../../components/constants.dart';
import 'booking_calendar_builder.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({
    super.key,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
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
                // Calendar View
                TableCalendar(
                  rowHeight: 52,
                  weekendDays: const [],
                  locale: 'en_US',
                  startingDayOfWeek: StartingDayOfWeek.saturday,
                  calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: AppCubit.get(context).isLightMode
                            ? Theme.of(context).indicatorColor.withOpacity(0.5)
                            : Theme.of(context).indicatorColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: AppCubit.get(context).isLightMode
                            ? Theme.of(context).indicatorColor
                            : Theme.of(context).indicatorColor.withOpacity(0.5),
                        shape: BoxShape.circle,
                      )),
                  focusedDay: cubit.focusedDay,
                  firstDay: DateTime.utc(2023, 5, 14),
                  lastDay: DateTime.utc(
                    finalYear,
                    cubit.firstDay.month,
                    cubit.firstDay.day,
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

                //States

                const BookingStates(),
                const SizedBox(
                  height: 12,
                ),
                Flexible(
                  child: ButtonsList(
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

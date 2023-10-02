import 'package:flutter/material.dart';
import 'package:padel_club/features/booking/presentation/view_models/booking_cubit/booking_cubit.dart';
import 'package:padel_club/features/home/presentation/view_models/home_cubit/home_cubit.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingCalendar extends StatelessWidget {
  const BookingCalendar({super.key, required this.bookingCubit});
  final BookingCubit bookingCubit;
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      rowHeight: 52,
      weekendDays: const [],
      locale: 'en_US',
      startingDayOfWeek: StartingDayOfWeek.saturday,
      calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: HomeCubit.get(context).isLightMode
                ? Theme.of(context).indicatorColor.withOpacity(0.5)
                : Theme.of(context).indicatorColor.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: HomeCubit.get(context).isLightMode
                ? Theme.of(context).indicatorColor
                : Theme.of(context).indicatorColor.withOpacity(0.5),
            shape: BoxShape.circle,
          )),
      focusedDay: bookingCubit.focusedDay,
      firstDay: DateTime.utc(2023, 9, 24),
      lastDay: DateTime.utc(
        bookingCubit.finalYear,
        bookingCubit.today.month,
        bookingCubit.today.day,
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      availableGestures: AvailableGestures.all,
      onDaySelected: (day, focusedDay) {
        BookingCubit.get(context).changeSelectedDay(day);
      },
      selectedDayPredicate: (day) {
        return isSameDay(day, bookingCubit.focusedDay);
      },
    );
  }
}

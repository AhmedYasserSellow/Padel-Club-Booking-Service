import 'package:booking/core/utilities/constants/constants.dart';
import 'package:booking/core/utilities/theme/logic/theme_cubit.dart';
import 'package:booking/layouts/home/logic/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingCalendar extends StatelessWidget {
  const BookingCalendar({super.key, required this.homeCubit});
  final HomeCubit homeCubit;
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
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
      focusedDay: homeCubit.focusedDay,
      firstDay: DateTime.utc(2023, 9, 24),
      lastDay: DateTime.utc(
        finalYear,
        homeCubit.today.month,
        homeCubit.today.day,
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      availableGestures: AvailableGestures.all,
      onDaySelected: (day, focusedDay) {
        HomeCubit.get(context).changeSelectedDay(day);
      },
      selectedDayPredicate: (day) {
        return isSameDay(day, homeCubit.focusedDay);
      },
    );
  }
}
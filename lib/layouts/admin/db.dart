import 'package:booking/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../logic/cubit.dart';

List<String> days = [
  'Saturday',
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
];

void createDatabase(String year, context) async {
  var cubit = AppCubit.get(context);
  for (cubit.monthDB = 1; cubit.monthDB <= 12; cubit.monthDB++) {
    for (cubit.dayDB = 1; cubit.dayDB <= 31; cubit.dayDB++) {
      for (cubit.indexDB = 0; cubit.indexDB <= 23; cubit.indexDB++) {
        await FirebaseFirestore.instance
            .collection(year)
            .doc('${cubit.monthDB}')
            .collection('${cubit.dayDB}')
            .doc('${abc[cubit.indexDB]}-${clock[cubit.indexDB]}')
            .set({
          'Name': '',
          'Phone': '',
          'State': '',
        });
        AppCubit.get(context).progressCalculator();
      }
    }
  }
  Navigator.pop(context);
}

void addAcdemy(
    int year, int month, int from, int to, String dayName, context) async {
  int day = 1;

  for (day = 1; day <= 31; day++) {
    for (var index = from; index < to; index++) {
      String dayNameResult =
          DateFormat('EEEE').format(DateTime.utc(year, month, day));

      if (dayNameResult == dayName) {
        await FirebaseFirestore.instance
            .collection('$year')
            .doc('$month')
            .collection('$day')
            .doc('${abc[index]}-${clock[index]}')
            .set({
          'Name': '',
          'Phone': '',
          'State': academy,
        });
      }
    }
  }
  Navigator.pop(context);
}

void removeAcdemy(
    int year, int month, int from, int to, String dayName, context) async {
  int day = 1;

  for (day = 1; day <= 31; day++) {
    for (var index = from; index < to; index++) {
      String dayNameResult =
          DateFormat('EEEE').format(DateTime.utc(year, month, day));

      if (dayNameResult == dayName) {
        await FirebaseFirestore.instance
            .collection('$year')
            .doc('$month')
            .collection('$day')
            .doc('${abc[index]}-${clock[index]}')
            .set({
          'Name': '',
          'Phone': '',
          'State': '',
        });
      }
    }
  }
  Navigator.pop(context);
}

void addPin(int year, int month, int from, int to, String dayName, String name,
    String phone, context) async {
  int day = 1;

  for (day = 1; day <= 31; day++) {
    for (var index = from; index < to; index++) {
      String dayNameResult =
          DateFormat('EEEE').format(DateTime.utc(year, month, day));

      if (dayNameResult == dayName) {
        await FirebaseFirestore.instance
            .collection('$year')
            .doc('$month')
            .collection('$day')
            .doc('${abc[index]}-${clock[index]}')
            .set({
          'Name': name,
          'Phone': phone,
          'State': booked,
        });
      }
    }
  }
  Navigator.pop(context);
}

void removePin(int year, int month, int from, int to, String dayName,
    String name, String phone, context) async {
  int day = 1;

  for (day = 1; day <= 31; day++) {
    for (var index = from; index < to; index++) {
      String dayNameResult =
          DateFormat('EEEE').format(DateTime.utc(year, month, day));

      if (dayNameResult == dayName) {
        await FirebaseFirestore.instance
            .collection('$year')
            .doc('$month')
            .collection('$day')
            .doc('${abc[index]}-${clock[index]}')
            .set(
          {
            'Name': '',
            'Phone': '',
            'State': '',
          },
        );
      }
    }
  }
  Navigator.pop(context);
}

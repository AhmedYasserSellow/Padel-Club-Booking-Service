import 'package:booking/core/utilities/constants/constants.dart';
import 'package:booking/core/utilities/services/service_locator.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void addAcdemy(
    int year, int month, int from, int to, String dayName, context) async {
  int day = 1;

  for (day = 1; day <= 31; day++) {
    for (var index = from; index < to; index++) {
      String dayNameResult =
          DateFormat('EEEE').format(DateTime.utc(year, month, day));

      if (dayNameResult == dayName) {
        await GetInstance.store
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
        await GetInstance.store
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

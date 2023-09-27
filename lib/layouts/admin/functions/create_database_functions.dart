import 'package:booking/components/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../logic/cubit.dart';

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

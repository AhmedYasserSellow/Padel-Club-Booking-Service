import 'package:booking/core/constants/constants.dart';
import 'package:booking/core/theme/theme.dart';
import 'package:booking/core/widgets/back_button.dart';
import 'package:booking/core/widgets/default_button.dart';
import 'package:booking/core/widgets/no_internet_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../logic/home_cubit.dart';

void pendingDialog(
  BuildContext context,
  int index,
  String selectedYear,
  String selectedMonth,
  String selectedDay,
  String name,
  String phonenumber,
  String bookingState,
  String firebaseID,
) async {
  final prefs = await SharedPreferences.getInstance();
  bool manager = prefs.getBool(dev) ?? false;
  if (context.mounted) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
            return AlertDialog(
              contentPadding: const EdgeInsets.only(
                  top: 24, right: 24, left: 24, bottom: 16),
              content: SingleChildScrollView(
                  child: Column(children: [
                Column(
                  children: [
                    Text('Name: $name'),
                    Text('Phone: $phonenumber'),
                    const SizedBox(
                      height: 24,
                    ),
                    manager
                        ? Column(
                            children: [
                              bookingState == pending
                                  ? Column(
                                      children: [
                                        defaultButton(
                                          onTap: () async {
                                            bool connectionState =
                                                await connection.hasConnection;
                                            if (connectionState == false) {
                                              if (context.mounted) {
                                                noInternetSnackBar(context);
                                              }
                                            } else {
                                              FirebaseFirestore.instance
                                                  .collection(selectedYear)
                                                  .doc(selectedMonth)
                                                  .collection(selectedDay)
                                                  .doc(
                                                      '${abc[index]}-${clock[index]}')
                                                  .set({
                                                'State': booked,
                                              }, SetOptions(merge: true));
                                              if (context.mounted) {
                                                Navigator.pop(context);
                                              }
                                            }
                                          },
                                          text: 'Confirm',
                                          color: availableColor,
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                              defaultButton(
                                onTap: () async {
                                  bool connectionState =
                                      await connection.hasConnection;
                                  if (connectionState == false) {
                                    if (context.mounted) {
                                      noInternetSnackBar(context);
                                    }
                                  } else {
                                    FirebaseFirestore.instance
                                        .collection(selectedYear)
                                        .doc(selectedMonth)
                                        .collection(selectedDay)
                                        .doc('${abc[index]}-${clock[index]}')
                                        .set({
                                      'Name': '',
                                      'Phone': '',
                                      'State': '',
                                    }, SetOptions(merge: true));
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                text: 'Cancel',
                                color: bookedColor,
                              ),
                            ],
                          )
                        : bookingState == pending
                            ? Column(
                                children: [
                                  const Text('to confirm your booking '),
                                  InkWell(
                                    child: const Text(
                                      'Chat With US',
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    onTap: () {
                                      HomeCubit.get(context)
                                          .navigateToMainPages(context, 4);
                                    },
                                  )
                                ],
                              )
                            : const SizedBox(),
                    const SizedBox(
                      height: 12,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MyBackButton(),
                      ],
                    ),
                  ],
                )
              ])),
            );
          });
        });
  }
}

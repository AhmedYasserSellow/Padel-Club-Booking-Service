import 'package:booking/core/utilities/constants/constants.dart';
import 'package:booking/core/utilities/services/service_locator.dart';
import 'package:booking/core/utilities/theme/theme.dart';
import 'package:booking/core/widgets/back_button.dart';
import 'package:booking/core/widgets/default_button.dart';
import 'package:booking/core/widgets/no_internet_snackbar.dart';
import 'package:booking/layouts/home/logic/home_cubit.dart';
import 'package:booking/layouts/home/models/time_button_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

void pendingDialog(
  BuildContext context,
  BookingServiceModel bookingServiceModel,
) async {
  final prefs = await GetInstance.prefs;
  bool manager = prefs.getBool(PrefsKeys.kAdmin) ?? false;
  String phone = prefs.getString(PrefsKeys.kPhone) ?? '';
  if (context.mounted) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding:
                const EdgeInsets.only(top: 24, right: 24, left: 24, bottom: 16),
            content: SingleChildScrollView(
                child: Column(children: [
              Column(
                children: [
                  Text('Name: ${bookingServiceModel.name}'),
                  Text('Phone: ${bookingServiceModel.phonenumber}'),
                  const SizedBox(
                    height: 24,
                  ),
                  manager
                      ? Column(
                          children: [
                            bookingServiceModel.state == pending
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
                                            GetInstance.store
                                                .collection(bookingServiceModel
                                                    .firebaseModel.selectedYear)
                                                .doc(bookingServiceModel
                                                    .firebaseModel
                                                    .selectedMonth)
                                                .collection(bookingServiceModel
                                                    .firebaseModel.selectedDay)
                                                .doc(
                                                    '${abc[bookingServiceModel.index]}-${clock[bookingServiceModel.index]}')
                                                .set({
                                              'State': booked,
                                            }, SetOptions(merge: true));
                                            if (context.mounted) {
                                              Navigator.pop(context);
                                            }
                                          }
                                        },
                                        text: 'Confirm',
                                        color: AppTheme.availableColor,
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
                                  GetInstance.store
                                      .collection(bookingServiceModel
                                          .firebaseModel.selectedYear)
                                      .doc(bookingServiceModel
                                          .firebaseModel.selectedMonth)
                                      .collection(bookingServiceModel
                                          .firebaseModel.selectedDay)
                                      .doc(
                                          '${abc[bookingServiceModel.index]}-${clock[bookingServiceModel.index]}')
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
                              color: AppTheme.bookedColor,
                            ),
                          ],
                        )
                      : bookingServiceModel.state == pending &&
                              phone == bookingServiceModel.phonenumber
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
                                    HomeCubit.get(context).navigateToMainPages(
                                      context,
                                      3,
                                      isDrawer: false,
                                    );
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
  }
}

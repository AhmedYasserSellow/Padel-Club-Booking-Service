import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/core/widgets/back_button.dart';
import 'package:padel_club/core/widgets/default_button.dart';
import 'package:padel_club/features/booking/data/models/booking_service_model.dart';
import 'package:padel_club/features/booking/presentation/view_models/booking_cubit/booking_cubit.dart';
import 'package:padel_club/features/home/presentation/view_models/home_cubit/home_cubit.dart';

void controlBookingDialog(
  BuildContext context,
  BookingServiceModel bookingServiceModel,
  BookingCubit cubit,
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
                                          cubit.confirmBooking(
                                            context,
                                            bookingServiceModel,
                                          );
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
                                cubit.cancelBooking(
                                  context,
                                  bookingServiceModel,
                                );
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

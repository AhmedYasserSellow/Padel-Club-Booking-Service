import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/features/booking/data/models/booking_service_model.dart';
import 'package:padel_club/features/booking/presentation/views/widgets/time_button.dart';

class ButtonsList extends StatelessWidget {
  const ButtonsList({super.key, required this.firebaseModel});
  final FirebaseModel firebaseModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
          future:
              GetInstance.store.collection('Control Panel').doc('Prices').get(),
          builder: (context, pricesSnapshot) {
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                Color? buttonColor;
                String name = firebaseModel.snapshot.data!.docs[index]['Name'];
                String phone =
                    firebaseModel.snapshot.data!.docs[index]['Phone'];
                String state =
                    firebaseModel.snapshot.data!.docs[index]['State'];
                if (state == pending) {
                  buttonColor = AppTheme.pendingColor;
                } else if (state == booked) {
                  buttonColor = AppTheme.bookedColor;
                } else if (state == academy) {
                  buttonColor = AppTheme.academyColor;
                } else {
                  buttonColor = AppTheme.availableColor;
                }

                return Column(
                  children: [
                    BookingTimeButton(
                      bookingServiceModel: BookingServiceModel(
                        firebaseModel: firebaseModel,
                        index: index,
                        buttonColor: buttonColor,
                        state: state,
                        name: name,
                        phonenumber: phone,
                        prices: pricesSnapshot,
                      ),
                    ),
                    index == 23
                        ? const SizedBox(
                            height: 12,
                          )
                        : const SizedBox()
                  ],
                );
              },
              itemCount: 24,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 12,
                );
              },
            );
          }),
    );
  }
}

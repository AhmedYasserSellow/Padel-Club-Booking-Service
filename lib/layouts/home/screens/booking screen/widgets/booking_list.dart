import 'package:booking/core/utilities/constants/constants.dart';
import 'package:booking/core/utilities/services/service_locator.dart';
import 'package:booking/core/utilities/theme/theme.dart';
import 'package:booking/layouts/home/screens/booking%20screen/widgets/time_button.dart';
import 'package:booking/layouts/home/models/time_button_model.dart';
import 'package:flutter/material.dart';

class ButtonsList extends StatelessWidget {
  const ButtonsList({super.key, required this.fireBaseModel});
  final FireBaseModel fireBaseModel;

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
                String name = fireBaseModel.snapshot.data!.docs[index]['Name'];
                String phone =
                    fireBaseModel.snapshot.data!.docs[index]['Phone'];
                String state =
                    fireBaseModel.snapshot.data!.docs[index]['State'];
                if (state == pending) {
                  buttonColor = pendingColor;
                } else if (state == booked) {
                  buttonColor = bookedColor;
                } else if (state == academy) {
                  buttonColor = academyColor;
                } else {
                  buttonColor = availableColor;
                }

                return Column(
                  children: [
                    BookingTimeButton(
                      bookingServiceModel: BookingServiceModel(
                        firebaseModel: fireBaseModel,
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

import 'package:booking/logic/cubit.dart';
import 'package:booking/logic/states.dart';
import 'package:booking/core/services/notifications.dart';
import 'package:booking/core/theme/theme.dart';
import 'package:booking/core/widgets/default_button.dart';
import 'package:booking/core/widgets/text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PricesScreen extends StatelessWidget {
  PricesScreen({super.key});
  final TextEditingController dayPriceController = TextEditingController();
  final TextEditingController nightPriceController = TextEditingController();
  final TextEditingController from = TextEditingController();
  final TextEditingController to = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Control Panel')
          .doc('Prices')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          int nightStartPM = snapshot.data!['Night Start PM'];
          int dayStartAM = snapshot.data!['Night End AM'];
          int dayPrice = snapshot.data!['Day'];
          int nightPrice = snapshot.data!['Night'];
          dayPriceController.text = dayPrice.toString();
          nightPriceController.text = nightPrice.toString();
          from.text = nightStartPM.toString();
          to.text = dayStartAM.toString();
          return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
            return Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Prices',
                    style: TextStyle(color: whiteTextColor),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: myTextFormField(
                          controller: dayPriceController,
                          type: TextInputType.number,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'day price is required';
                            }

                            return null;
                          },
                          label: 'Day',
                          prefix: Icons.numbers,
                          context: context,
                          color: whiteTextColor,
                          textStyleColor: whiteTextColor,
                          labelColor: whiteTextColor,
                          focusColor: whiteTextColor,
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: myTextFormField(
                          controller: nightPriceController,
                          type: TextInputType.number,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'night price is required';
                            }

                            return null;
                          },
                          label: 'Night',
                          prefix: Icons.numbers,
                          context: context,
                          color: whiteTextColor,
                          textStyleColor: whiteTextColor,
                          labelColor: whiteTextColor,
                          focusColor: whiteTextColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Night Time 24H Format',
                    style: TextStyle(color: whiteTextColor),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: myTextFormField(
                          controller: from,
                          type: TextInputType.number,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'ending time is required';
                            }

                            if (int.tryParse(value)! > 23) {
                              return 'enter a valid starting time';
                            }
                            return null;
                          },
                          label: 'From',
                          prefix: Icons.numbers,
                          context: context,
                          color: whiteTextColor,
                          textStyleColor: whiteTextColor,
                          labelColor: whiteTextColor,
                          focusColor: whiteTextColor,
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: myTextFormField(
                          controller: to,
                          type: TextInputType.number,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'ending time is required';
                            }
                            if (int.tryParse(value)! == 0) {
                              return 'please enter 24 instead';
                            }
                            if (int.tryParse(value)! > 23 &&
                                int.tryParse(value) != 24) {
                              return 'enter a valid starting time';
                            }
                            return null;
                          },
                          label: 'To',
                          prefix: Icons.numbers,
                          context: context,
                          color: whiteTextColor,
                          textStyleColor: whiteTextColor,
                          labelColor: whiteTextColor,
                          focusColor: whiteTextColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  defaultButton(
                    onTap: () {
                      FirebaseFirestore.instance
                          .collection('Control Panel')
                          .doc('Prices')
                          .set({
                        'Day': int.tryParse(dayPriceController.text),
                        'Night': int.tryParse(nightPriceController.text),
                        'Night End AM': int.tryParse(to.text),
                        'Night Start PM': int.tryParse(from.text),
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: racketFirstColor,
                          content: Text(
                            'Prices Changed',
                            style: TextStyle(
                              color: whiteTextColor,
                            ),
                          ),
                        ),
                      );
                      sendGlobalNotification(
                        title: 'Price Changed',
                        body: 'Check our new prices',
                      );
                    },
                    text: 'Sumbit New Prices',
                    color: racketFirstColor,
                  ),
                ],
              ),
            );
          });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

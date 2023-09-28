import 'package:booking/core/utilities/constants/constants.dart';
import 'package:booking/core/utilities/services/notifications.dart';
import 'package:booking/core/utilities/theme/theme.dart';
import 'package:booking/core/widgets/back_button.dart';
import 'package:booking/core/widgets/text_form_field.dart';
import 'package:booking/layouts/home/logic/home_cubit.dart';
import 'package:booking/layouts/home/models/time_button_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void bookingDialog(
  BuildContext context,
  BookingServiceModel bookingServiceModel,
) async {
  final prefs = await SharedPreferences.getInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  nameController.text = prefs.getString('Name') ?? '';
  phoneNumberController.text = prefs.getString('Phone') ?? '';
  bool manager = prefs.getBool(dev) ?? false;
  String myID = prefs.getString(id)!;
  if (context.mounted) {
    showDialog(
      context: context,
      builder: (context) {
        GlobalKey<FormState> formKey = GlobalKey<FormState>();
        int? price;
        if ((bookingServiceModel.index >= 0 &&
                bookingServiceModel.index <=
                    bookingServiceModel.prices.data!['Night End AM']) ||
            (bookingServiceModel.index >=
                bookingServiceModel.prices.data!['Night Start PM'])) {
          price = bookingServiceModel.prices.data!['Night'];
        } else {
          price = bookingServiceModel.prices.data!['Day'];
        }

        return AlertDialog(
          contentPadding:
              const EdgeInsets.only(top: 24, right: 24, left: 24, bottom: 16),
          titlePadding: EdgeInsets.zero,
          //Price

          //Form----------------------------------------------------------------------------------------------------------------------

          content: SingleChildScrollView(
            child: SafeArea(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    myTextFormField(
                      textStyleColor: HomeCubit.get(context).iconAndTextColor,
                      color: HomeCubit.get(context).iconAndTextColor,
                      context: context,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "your name is required";
                        }
                        return null;
                      },
                      label: "Your Name",
                      controller: nameController,
                      type: TextInputType.name,
                      prefix: Icons.title,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    myTextFormField(
                      textStyleColor: HomeCubit.get(context).iconAndTextColor,
                      color: HomeCubit.get(context).iconAndTextColor,
                      limit: 11,
                      context: context,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return "your mobile number is required";
                        }

                        if (!value.startsWith('01') || value.length != 11) {
                          return 'enter a valid phone number';
                        }
                        return null;
                      },
                      controller: phoneNumberController,
                      type: TextInputType.phone,
                      label: "Mobile Number",
                      prefix: Icons.phone,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      'Price:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      '$price.00 EGP',
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const MyBackButton(),
                        const SizedBox(
                          width: 8,
                        ),
                        TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => availableColor)),
                          child: Text(
                            'Book',
                            style: TextStyle(color: whiteTextColor),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (manager) {
                                FirebaseFirestore.instance
                                    .collection(bookingServiceModel
                                        .firebaseModel.selectedYear)
                                    .doc(bookingServiceModel
                                        .firebaseModel.selectedMonth)
                                    .collection(bookingServiceModel
                                        .firebaseModel.selectedDay)
                                    .doc(
                                        '${abc[bookingServiceModel.index]}-${clock[bookingServiceModel.index]}')
                                    .set({
                                  'Name': nameController.text,
                                  'Phone': phoneNumberController.text,
                                  'State': booked,
                                });
                              } else {
                                FirebaseFirestore.instance
                                    .collection(bookingServiceModel
                                        .firebaseModel.selectedYear)
                                    .doc(bookingServiceModel
                                        .firebaseModel.selectedMonth)
                                    .collection(bookingServiceModel
                                        .firebaseModel.selectedDay)
                                    .doc(
                                        '${abc[bookingServiceModel.index]}-${clock[bookingServiceModel.index]}')
                                    .set({
                                  'Name': nameController.text,
                                  'Phone': phoneNumberController.text,
                                  'State': pending,
                                  'Created at': DateTime.now(),
                                });

                                sendNotify(
                                  id: '${bookingServiceModel.firebaseModel.selectedDay}${bookingServiceModel.firebaseModel.selectedMonth}${bookingServiceModel.firebaseModel.selectedYear}${clock[bookingServiceModel.index]}',
                                  title: nameController.text,
                                  body:
                                      'Date : ${bookingServiceModel.firebaseModel.selectedDay}/${bookingServiceModel.firebaseModel.selectedMonth}/${bookingServiceModel.firebaseModel.selectedYear} \nTime : ${clock[bookingServiceModel.index]}',
                                );
                                FirebaseFirestore.instance
                                    .collection('Chats')
                                    .doc('0')
                                    .collection(myID)
                                    .add({
                                  'Message':
                                      'I have send a book request\nDate : ${bookingServiceModel.firebaseModel.selectedDay}/${bookingServiceModel.firebaseModel.selectedMonth}/${bookingServiceModel.firebaseModel.selectedYear} \nTime : ${clock[bookingServiceModel.index]}',
                                  'ID': myID,
                                  'Created at': DateTime.now(),
                                });
                                FirebaseFirestore.instance
                                    .collection('App Users')
                                    .doc(myID)
                                    .set(
                                        {
                                      'Last Message': DateTime.now(),
                                      'Message':
                                          'I have send a book request\nDate : ${bookingServiceModel.firebaseModel.selectedDay}/${bookingServiceModel.firebaseModel.selectedMonth}/${bookingServiceModel.firebaseModel.selectedYear} \nTime : ${clock[bookingServiceModel.index]}',
                                    },
                                        SetOptions(
                                          merge: true,
                                        ));
                              }
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

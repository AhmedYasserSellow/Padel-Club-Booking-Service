import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/cubit.dart';
import '../components/constants.dart';
import '../components/theme.dart';
import '../components/widgets/back_button.dart';
import '../components/widgets/text_form_field.dart';

void bookingDialog(
    BuildContext context,
    int index,
    String selectedYear,
    String selectedMonth,
    String selectedDay,
    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> prices) async {
  final prefs = await SharedPreferences.getInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  nameController.text = prefs.getString('Name') ?? '';
  phoneNumberController.text = prefs.getString('Phone') ?? '';
  bool manager = prefs.getBool(dev) ?? false;
  if (context.mounted) {
    showDialog(
      context: context,
      builder: (context) {
        var formKey = GlobalKey<FormState>();
        int? price;
        if ((index >= 0 && index <= prices.data!['Night End AM']) ||
            (index >= prices.data!['Night Start PM'])) {
          price = prices.data!['Night'];
        } else {
          price = prices.data!['Day'];
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
                      textStyleColor: AppCubit.get(context).iconAndTextColor,
                      color: AppCubit.get(context).iconAndTextColor,
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
                      textStyleColor: AppCubit.get(context).iconAndTextColor,
                      color: AppCubit.get(context).iconAndTextColor,
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
                            style: TextStyle(color: textColor),
                          ),
                          onPressed: () async {
                            bool connectionState =
                                await connection.hasConnection;
                            if (formKey.currentState!.validate()) {
                              if (connectionState == false) {
                                if (context.mounted) {
                                  noInternetSnackBar(context);
                                }
                              } else {
                                if (manager) {
                                  FirebaseFirestore.instance
                                      .collection(selectedYear)
                                      .doc(selectedMonth)
                                      .collection(selectedDay)
                                      .doc('${abc[index]}-${clock[index]}')
                                      .set({
                                    'Name': nameController.text,
                                    'Phone': phoneNumberController.text,
                                    'State': booked,
                                  });
                                } else {
                                  FirebaseFirestore.instance
                                      .collection(selectedYear)
                                      .doc(selectedMonth)
                                      .collection(selectedDay)
                                      .doc('${abc[index]}-${clock[index]}')
                                      .set({
                                    'Name': nameController.text,
                                    'Phone': phoneNumberController.text,
                                    'State': pending,
                                  });
                                }
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
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

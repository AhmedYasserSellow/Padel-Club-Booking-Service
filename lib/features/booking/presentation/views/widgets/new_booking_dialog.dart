import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/core/widgets/back_button.dart';
import 'package:padel_club/core/widgets/text_form_field.dart';
import 'package:padel_club/features/booking/data/models/booking_service_model.dart';
import 'package:padel_club/features/booking/presentation/view_models/booking_cubit/booking_cubit.dart';

import 'package:padel_club/features/home/presentation/view_models/home_cubit/home_cubit.dart';

void addNewBookingDialog(
  BuildContext context,
  BookingServiceModel bookingServiceModel,
  BookingCubit cubit,
) async {
  final prefs = await GetInstance.prefs;

  cubit.nameController.text = prefs.getString('Name') ?? '';
  cubit.phoneNumberController.text = prefs.getString('Phone') ?? '';
  bool manager = prefs.getBool(PrefsKeys.kAdmin) ?? false;
  String myID = prefs.getString(PrefsKeys.kFirebaseID)!;
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
          content: SingleChildScrollView(
            child: SafeArea(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    myTextFormField(
                      borderColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.black
                              : Colors.white,
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
                      controller: cubit.nameController,
                      type: TextInputType.name,
                      prefix: Icons.title,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    myTextFormField(
                      borderColor:
                          Theme.of(context).brightness == Brightness.light
                              ? Colors.black
                              : Colors.white,
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
                      controller: cubit.phoneNumberController,
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
                                  (states) => AppTheme.availableColor)),
                          child: Text(
                            'Book',
                            style: TextStyle(color: AppTheme.whiteTextColor),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.addBooking(
                                  context, bookingServiceModel, manager, myID);
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

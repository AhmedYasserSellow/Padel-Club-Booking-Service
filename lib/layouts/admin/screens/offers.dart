import 'package:booking/logic/cubit.dart';
import 'package:booking/logic/states.dart';
import 'package:booking/components/services/notifications.dart';
import 'package:booking/components/theme/theme.dart';
import 'package:booking/components/widgets/default_button.dart';
import 'package:booking/components/widgets/text_form_field.dart';
import 'package:booking/layouts/home/screens/offers%20screen/offers_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControlOffers extends StatelessWidget {
  ControlOffers({super.key});

  final TextEditingController offerTitleController = TextEditingController();
  final TextEditingController offerControllerImage = TextEditingController();
  final TextEditingController offerControllerLink = TextEditingController();
  final TextEditingController offerIDController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
      return Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Offer',
              style: TextStyle(color: whiteTextColor),
            ),
            const SizedBox(
              height: 12,
            ),
            myTextFormField(
              controller: offerIDController,
              type: TextInputType.number,
              validate: (String? value) {
                if (value!.isEmpty) {
                  return 'offer id is required';
                }

                return null;
              },
              label: 'ID',
              prefix: Icons.numbers,
              context: context,
              color: whiteTextColor,
              textStyleColor: whiteTextColor,
              focusColor: whiteTextColor,
              labelColor: whiteTextColor,
            ),
            const SizedBox(
              height: 12,
            ),
            myTextFormField(
              controller: offerTitleController,
              type: TextInputType.text,
              validate: (String? value) {
                if (value!.isEmpty) {
                  return 'offer title is required';
                }

                return null;
              },
              label: 'Title',
              prefix: Icons.title,
              context: context,
              color: whiteTextColor,
              textStyleColor: whiteTextColor,
              focusColor: whiteTextColor,
              labelColor: whiteTextColor,
            ),
            const SizedBox(
              height: 12,
            ),
            myTextFormField(
              controller: offerControllerImage,
              type: TextInputType.url,
              validate: (String? value) {
                if (value!.isEmpty) {
                  return 'image url is required';
                }

                return null;
              },
              label: 'Image Url',
              prefix: Icons.image_outlined,
              context: context,
              color: whiteTextColor,
              textStyleColor: whiteTextColor,
              focusColor: whiteTextColor,
              labelColor: whiteTextColor,
            ),
            const SizedBox(
              height: 12,
            ),
            myTextFormField(
              controller: offerControllerLink,
              type: TextInputType.url,
              validate: (String? value) {
                return null;
              },
              label: 'Post Url',
              prefix: Icons.link_rounded,
              context: context,
              color: whiteTextColor,
              textStyleColor: whiteTextColor,
              focusColor: whiteTextColor,
              labelColor: whiteTextColor,
            ),
            const SizedBox(
              height: 12,
            ),
            defaultButton(
              text: 'Add Offer',
              color: racketFirstColor,
              onTap: () {
                if (formKey.currentState!.validate()) {
                  FirebaseFirestore.instance
                      .collection('Offers')
                      .doc(offerIDController.text)
                      .set({
                    'title': offerTitleController.text,
                    'image': offerControllerImage.text,
                    'Link': offerControllerLink.text,
                    'id': offerIDController.text,
                  });
                  sendGlobalNotification(
                    title: 'New Offer',
                    body: 'Open to see our new offer',
                  );
                  offerControllerImage.clear();
                  offerControllerLink.clear();
                  offerIDController.clear();
                  offerTitleController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Offer Added',
                        style: TextStyle(
                          color: whiteTextColor,
                        ),
                      ),
                      backgroundColor: racketFirstColor,
                    ),
                  );
                }
              },
            ),
            const SizedBox(
              height: 12,
            ),
            defaultButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              racketFirstColor,
                              racketSecondColor,
                            ],
                          ),
                        ),
                        child: Scaffold(
                          backgroundColor: Colors.transparent,
                          appBar: AppBar(
                            leading: BackButton(
                              color: whiteTextColor,
                            ),
                            title: Text(
                              'Offers',
                              style: TextStyle(
                                color: whiteTextColor,
                              ),
                            ),
                            centerTitle: true,
                            backgroundColor: Colors.transparent,
                          ),
                          body: const OffersScreen(removeFeature: true),
                        ),
                      );
                    },
                  ),
                );
              },
              text: 'Offers Screen',
              color: whatsAppColor,
            )
          ],
        ),
      );
    });
  }
}

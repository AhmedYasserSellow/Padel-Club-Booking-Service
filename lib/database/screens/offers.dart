import 'package:booking/bloc/cubit.dart';
import 'package:booking/bloc/states.dart';
import 'package:booking/components/theme.dart';
import 'package:booking/components/widgets/default_button.dart';
import 'package:booking/components/widgets/text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ControlOffers extends StatelessWidget {
  ControlOffers({super.key});

  final TextEditingController offerTitleController = TextEditingController();
  final TextEditingController offerControllerImage = TextEditingController();
  final TextEditingController offerControllerLink = TextEditingController();

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
              style: TextStyle(color: textColor),
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
              color: textColor,
              textStyleColor: textColor,
              focusColor: textColor,
              labelColor: textColor,
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
              prefix: Icons.link_rounded,
              context: context,
              color: textColor,
              textStyleColor: textColor,
              focusColor: textColor,
              labelColor: textColor,
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
              color: textColor,
              textStyleColor: textColor,
              focusColor: textColor,
              labelColor: textColor,
            ),
            const SizedBox(
              height: 12,
            ),
            defaultButton(
              text: 'Add Offer',
              color: racketFirstColor,
              onTap: () {
                if (formKey.currentState!.validate()) {
                  FirebaseFirestore.instance.collection('Offers').add({
                    'title': offerTitleController.text,
                    'image': offerControllerImage.text,
                    'Link': offerControllerLink.text,
                  });
                }
              },
            )
          ],
        ),
      );
    });
  }
}

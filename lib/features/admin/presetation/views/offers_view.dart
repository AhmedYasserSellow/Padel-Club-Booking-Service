import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/core/widgets/default_button.dart';
import 'package:padel_club/core/widgets/text_form_field.dart';
import 'package:padel_club/features/admin/presetation/view_model/admin_cubit/admin_cubit.dart';
import 'package:padel_club/features/admin/presetation/view_model/cubit/offers_cubit.dart';

class ControlOffers extends StatelessWidget {
  const ControlOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OffersCubit(),
      child: BlocBuilder<AdminCubit, AdminState>(builder: (context, state) {
        OffersCubit cubit = OffersCubit.get(context);
        return Form(
          key: cubit.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Offer',
                style: TextStyle(color: AppTheme.whiteTextColor),
              ),
              const SizedBox(
                height: 12,
              ),
              myTextFormField(
                controller: cubit.offerIDController,
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
                color: AppTheme.whiteTextColor,
                textStyleColor: AppTheme.whiteTextColor,
                focusColor: AppTheme.whiteTextColor,
                labelColor: AppTheme.whiteTextColor,
              ),
              const SizedBox(
                height: 12,
              ),
              myTextFormField(
                controller: cubit.offerTitleController,
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
                color: AppTheme.whiteTextColor,
                textStyleColor: AppTheme.whiteTextColor,
                focusColor: AppTheme.whiteTextColor,
                labelColor: AppTheme.whiteTextColor,
              ),
              const SizedBox(
                height: 12,
              ),
              myTextFormField(
                controller: cubit.offerControllerImage,
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
                color: AppTheme.whiteTextColor,
                textStyleColor: AppTheme.whiteTextColor,
                focusColor: AppTheme.whiteTextColor,
                labelColor: AppTheme.whiteTextColor,
              ),
              const SizedBox(
                height: 12,
              ),
              myTextFormField(
                controller: cubit.offerControllerLink,
                type: TextInputType.url,
                validate: (String? value) {
                  return null;
                },
                label: 'Post Url',
                prefix: Icons.link_rounded,
                context: context,
                color: AppTheme.whiteTextColor,
                textStyleColor: AppTheme.whiteTextColor,
                focusColor: AppTheme.whiteTextColor,
                labelColor: AppTheme.whiteTextColor,
              ),
              const SizedBox(
                height: 12,
              ),
              defaultButton(
                text: 'Add Offer',
                color: AppTheme.racketFirstColor,
                onTap: () {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.addOffers(context);
                  }
                },
              ),
              const SizedBox(
                height: 12,
              ),
              defaultButton(
                onTap: () {
                  cubit.openOffersScreen(context);
                },
                text: 'Offers Screen',
                color: AppTheme.whatsAppColor,
              )
            ],
          ),
        );
      }),
    );
  }
}

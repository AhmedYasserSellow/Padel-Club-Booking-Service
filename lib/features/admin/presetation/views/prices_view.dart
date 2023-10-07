import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/core/widgets/default_button.dart';
import 'package:padel_club/core/widgets/loading_indicator.dart';
import 'package:padel_club/core/widgets/text_form_field.dart';
import 'package:padel_club/features/admin/presetation/view_model/prices_cubit/prices_cubit.dart';

class PricesScreen extends StatelessWidget {
  const PricesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PricesCubit(),
      child: BlocBuilder<PricesCubit, PricesState>(
        builder: (context, state) {
          PricesCubit cubit = PricesCubit.get(context);
          return StreamBuilder(
            stream: GetInstance.store
                .collection('Control Panel')
                .doc('Prices')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                int nightStartPM = snapshot.data!['Night Start PM'];
                int dayStartAM = snapshot.data!['Night End AM'];
                int dayPrice = snapshot.data!['Day'];
                int nightPrice = snapshot.data!['Night'];
                cubit.dayPriceController.text = dayPrice.toString();
                cubit.nightPriceController.text = nightPrice.toString();
                cubit.from.text = nightStartPM.toString();
                cubit.to.text = dayStartAM.toString();
                return Form(
                  key: cubit.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Prices',
                        style: TextStyle(color: AppTheme.whiteTextColor),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: myTextFormField(
                              controller: cubit.dayPriceController,
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
                              color: AppTheme.whiteTextColor,
                              textStyleColor: AppTheme.whiteTextColor,
                              labelColor: AppTheme.whiteTextColor,
                              focusColor: AppTheme.whiteTextColor,
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Expanded(
                            child: myTextFormField(
                              controller: cubit.nightPriceController,
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
                              color: AppTheme.whiteTextColor,
                              textStyleColor: AppTheme.whiteTextColor,
                              labelColor: AppTheme.whiteTextColor,
                              focusColor: AppTheme.whiteTextColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Night Time 24H Format',
                        style: TextStyle(color: AppTheme.whiteTextColor),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: myTextFormField(
                              controller: cubit.from,
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
                              color: AppTheme.whiteTextColor,
                              textStyleColor: AppTheme.whiteTextColor,
                              labelColor: AppTheme.whiteTextColor,
                              focusColor: AppTheme.whiteTextColor,
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Expanded(
                            child: myTextFormField(
                              controller: cubit.to,
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
                              color: AppTheme.whiteTextColor,
                              textStyleColor: AppTheme.whiteTextColor,
                              labelColor: AppTheme.whiteTextColor,
                              focusColor: AppTheme.whiteTextColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      defaultButton(
                        onTap: () {
                          cubit.changePrices(context);
                        },
                        text: 'Sumbit New Prices',
                        color: AppTheme.racketFirstColor,
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: LoadingIndicator(),
                );
              }
            },
          );
        },
      ),
    );
  }
}

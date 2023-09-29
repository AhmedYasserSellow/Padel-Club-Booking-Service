import 'package:booking/core/utilities/services/service_locator.dart';
import 'package:booking/layouts/home/logic/home_cubit.dart';
import 'package:booking/layouts/home/screens/offers%20screen/widgets/offers_list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({
    super.key,
    required this.removeFeature,
  });
  final bool removeFeature;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return StreamBuilder(
        stream: GetInstance.store.collection('Offers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return OffersListBuilder(
              isOpenedFromDashboard: removeFeature,
              offers: snapshot.data!.docs,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    });
  }
}

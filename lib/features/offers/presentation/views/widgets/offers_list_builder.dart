import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/core/widgets/loading_indicator.dart';
import 'package:padel_club/features/offers/presentation/views/widgets/no_offers_view.dart';
import 'package:padel_club/features/offers/presentation/views/widgets/offers_list_view.dart';

class OffersListBuilder extends StatelessWidget {
  const OffersListBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: GetInstance.store.collection('Offers').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isNotEmpty) {
            return OffersListView(
              offers: snapshot.data!.docs,
            );
          } else {
            return const NoOffersView();
          }
        } else {
          return const LoadingIndicator();
        }
      },
    );
  }
}

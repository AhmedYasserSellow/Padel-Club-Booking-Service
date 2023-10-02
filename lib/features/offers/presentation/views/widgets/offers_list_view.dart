import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:padel_club/features/offers/data/models/offers_model.dart';
import 'package:padel_club/features/offers/presentation/views/widgets/offers_list_view_item.dart';

class OffersListView extends StatelessWidget {
  const OffersListView({
    super.key,
    required this.offers,
  });

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> offers;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: offers.length,
        itemBuilder: (context, index) {
          return OffersListViewItem(
              offerModel: OfferModel(
            offerName: offers[index]['title'],
            imageUrl: offers[index]['image'],
            postUrl: offers[index]['Link'],
          ));
        },
      ),
    );
  }
}

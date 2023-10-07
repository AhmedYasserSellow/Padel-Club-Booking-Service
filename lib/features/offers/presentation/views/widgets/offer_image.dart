import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:padel_club/features/offers/data/models/offers_model.dart';

class OfferImage extends StatelessWidget {
  const OfferImage({
    super.key,
    required this.offerModel,
  });
  final OfferModel offerModel;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: offerModel.imageUrl,
      ),
    );
  }
}

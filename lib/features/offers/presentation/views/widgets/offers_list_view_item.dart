import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/features/offers/data/models/offers_model.dart';
import 'package:padel_club/features/offers/presentation/views/widgets/offer_image.dart';
import 'package:padel_club/features/offers/presentation/views/widgets/offers_details_view.dart';

class OffersListViewItem extends StatelessWidget {
  const OffersListViewItem({
    super.key,
    required this.offerModel,
  });

  final OfferModel offerModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        right: 20,
        left: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            offerModel.offerName,
            style: TextStyle(
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : AppTheme.whiteTextColor),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return OfferDetailsView(
                        offerModel: offerModel,
                      );
                    },
                  ),
                );
              },
              child: OfferImage(
                offerModel: offerModel,
              )),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/features/home/presentation/view_models/home_cubit/home_cubit.dart';
import 'package:padel_club/features/offers/data/models/offers_model.dart';
import 'package:padel_club/features/offers/presentation/views/widgets/open_post_button.dart';
import 'package:padel_club/features/offers/presentation/views/widgets/remove_offer_dialog.dart';
import 'package:photo_view/photo_view.dart';

class OfferDetailsView extends StatelessWidget {
  const OfferDetailsView({
    super.key,
    required this.offerModel,
  });
  final OfferModel offerModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          offerModel.offerName,
          style: const TextStyle(color: Colors.white),
        ),
        actions: HomeCubit.get(context).manager
            ? [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => RemoveOfferDialog(
                                id: offerModel.id,
                              ));
                    },
                    icon: Icon(FontAwesomeIcons.trashCan,
                        color: AppTheme.bookedColor),
                  ),
                ),
              ]
            : [],
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: PhotoView(
            imageProvider: NetworkImage(offerModel.imageUrl),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 75,
        elevation: 0,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OpenPostButton(
              icon: FontAwesomeIcons.facebook,
              url: offerModel.facebookUrl,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: VerticalDivider(
                width: 1,
              ),
            ),
            OpenPostButton(
              icon: FontAwesomeIcons.instagram,
              url: offerModel.instagramUrl,
            ),
          ],
        ),
      ),
    );
  }
}

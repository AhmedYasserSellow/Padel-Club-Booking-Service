import 'package:booking/bloc/cubit.dart';
import 'package:booking/components/theme.dart';
import 'package:booking/components/widgets/default_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OffersListBuilder extends StatelessWidget {
  const OffersListBuilder({
    super.key,
    required this.offers,
    required this.removeFeature,
  });
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> offers;
  final bool removeFeature;
  @override
  Widget build(BuildContext context) {
    if (offers.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: offers.length,
          itemBuilder: (context, index) {
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
                    removeFeature
                        ? 'ID :  ${offers[index]['id']}'
                        : offers[index]['title'],
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: removeFeature
                            ? textColor
                            : AppCubit.get(context).iconAndTextColor),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      if (offers[index]['Link'] != '') {
                        launchUrlString(offers[index]['Link']);
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: offers[index]['image'],
                      ),
                    ),
                  ),
                  removeFeature
                      ? const SizedBox(
                          height: 15,
                        )
                      : const SizedBox(),
                  removeFeature
                      ? defaultButton(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection('Offers')
                                .doc(offers[index]['id'])
                                .delete();
                          },
                          text: 'Remove Offer',
                          color: Colors.red,
                        )
                      : const SizedBox(),
                ],
              ),
            );
          },
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage(
                'assets/no_offer.png',
              ),
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'There is no offers right now',
              style: TextStyle(
                color: AppCubit.get(context).iconAndTextColor,
                fontSize: 20,
              ),
            )
          ],
        ),
      );
    }
  }
}
import 'package:booking/core/utilities/services/service_locator.dart';
import 'package:booking/layouts/home/screens/offers%20screen/widgets/no_offers_screen.dart';
import 'package:booking/core/utilities/theme/theme.dart';
import 'package:booking/core/widgets/default_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OffersListBuilder extends StatelessWidget {
  const OffersListBuilder({
    super.key,
    required this.offers,
    required this.isOpenedFromDashboard,
  });
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> offers;
  final bool isOpenedFromDashboard;
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
                    isOpenedFromDashboard
                        ? 'ID :  ${offers[index]['id']}'
                        : offers[index]['title'],
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: isOpenedFromDashboard
                            ? whiteTextColor
                            : Theme.of(context).brightness == Brightness.light
                                ? Colors.black
                                : whiteTextColor),
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
                  isOpenedFromDashboard
                      ? const SizedBox(
                          height: 15,
                        )
                      : const SizedBox(),
                  isOpenedFromDashboard
                      ? defaultButton(
                          onTap: () {
                            GetInstance.store
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
      return NoOffersScreen(isOpenedFromDashboard: isOpenedFromDashboard);
    }
  }
}

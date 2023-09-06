import 'package:booking/bloc/cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OffersListBuilder extends StatelessWidget {
  const OffersListBuilder({super.key, required this.offers});
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> offers;
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
                    offers[index]['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
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

import 'package:booking/bloc/cubit.dart';
import 'package:booking/bloc/states.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> offers = [];
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Offers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            offers = snapshot.data!.docs;
            if (offers.isNotEmpty) {
              return ListView.separated(
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: offers[index]['image'],
                    width: 100,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 15,
                  );
                },
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

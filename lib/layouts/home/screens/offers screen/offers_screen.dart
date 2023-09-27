import 'package:booking/logic/cubit.dart';
import 'package:booking/logic/states.dart';
import 'package:booking/layouts/home/screens/offers%20screen/offers_list_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
      return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Offers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return OffersListBuilder(
              isOpenedFromDashboard: removeFeature,
              offers: snapshot.data!.docs,
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'No Internet Connection',
                style: TextStyle(fontSize: 20),
              ),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

part 'firebase_data_model.dart';

class BookingServiceModel {
  final int index;
  final FirebaseModel firebaseModel;
  final Color? buttonColor;
  final String state;
  final String name;
  final String phonenumber;
  final AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> prices;

  BookingServiceModel({
    required this.firebaseModel,
    required this.index,
    required this.buttonColor,
    required this.state,
    required this.name,
    required this.phonenumber,
    required this.prices,
  });
}

import 'package:flutter/material.dart';

abstract class AuthRepo {
  Future logInForAdmin(
    BuildContext context,
    AsyncSnapshot snapshot,
    TextEditingController adminPhone,
    TextEditingController adminPassword,
  );
  Future logInForUser(
    BuildContext context,
  );
}

import 'package:flutter/material.dart';

abstract class HomeRepo {
  Future logOut(BuildContext context);

  Future updateProfile(
    BuildContext context,
    TextEditingController profileNameController,
    TextEditingController profilePhoneController,
  );
}

import 'package:flutter/material.dart';
import 'package:padel_club/features/admin/data/models/time_model.dart';

abstract class AdminRepo {
  Future addAcademyTimes(
    BuildContext context,
    TimeModel timeModel,
  );
  Future removeAcademyTimes(
    BuildContext context,
    TimeModel timeModel,
  );
  Future addPinnedTimes(
    BuildContext context,
    TimeModel timeModel,
    String name,
    String phone,
  );
  Future removePinnedTimes(
    BuildContext context,
    TimeModel timeModel,
  );
  Future addNewYearToDatabase(
    BuildContext context,
    String year,
  );

  void changePrices(
    BuildContext context,
  );
  void addOffers(
    BuildContext context,
  );
}

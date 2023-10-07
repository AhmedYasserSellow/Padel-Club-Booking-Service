import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:padel_club/core/extensions/extensions.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/services/notifications.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/features/admin/data/models/time_model.dart';
import 'package:padel_club/features/admin/data/repos/admin_repo.dart';
import 'package:padel_club/features/admin/presetation/view_model/offers_cubit/offers_cubit.dart';
import 'package:padel_club/features/admin/presetation/view_model/database_years_cubit/database_years_cubit.dart';
import 'package:padel_club/features/admin/presetation/view_model/prices_cubit/prices_cubit.dart';
import 'package:padel_club/features/auth/presentation/views/auth_view.dart';

class AdminRepoImpl extends AdminRepo {
  @override
  Future addAcademyTimes(
    BuildContext context,
    TimeModel timeModel,
  ) async {
    for (int day = 1; day <= 31; day++) {
      for (var index = timeModel.start.toInt();
          index < timeModel.end.toInt();
          index++) {
        String dayNameResult = DateFormat('EEEE').format(
            DateTime.utc(timeModel.year.toInt(), timeModel.month.toInt(), day));

        if (dayNameResult == timeModel.dayName) {
          await GetInstance.store
              .collection(timeModel.year)
              .doc(timeModel.month)
              .collection('$day')
              .doc('${abc[index]}-${clock[index]}')
              .set({
            'Name': '',
            'Phone': '',
            'State': academy,
          });
        }
      }
    }
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Future removeAcademyTimes(
    BuildContext context,
    TimeModel timeModel,
  ) async {
    for (int day = 1; day <= 31; day++) {
      for (var index = timeModel.start.toInt();
          index < timeModel.end.toInt();
          index++) {
        String dayNameResult = DateFormat('EEEE').format(
            DateTime.utc(timeModel.year.toInt(), timeModel.month.toInt(), day));

        if (dayNameResult == timeModel.dayName) {
          await GetInstance.store
              .collection(timeModel.year)
              .doc(timeModel.month)
              .collection('$day')
              .doc('${abc[index]}-${clock[index]}')
              .set({
            'Name': '',
            'Phone': '',
            'State': '',
          });
        }
      }
    }
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Future addPinnedTimes(
    BuildContext context,
    TimeModel timeModel,
    String name,
    String phone,
  ) async {
    for (int day = 1; day <= 31; day++) {
      for (var index = timeModel.start.toInt();
          index < timeModel.end.toInt();
          index++) {
        String dayNameResult = DateFormat('EEEE').format(
            DateTime.utc(timeModel.year.toInt(), timeModel.month.toInt(), day));

        if (dayNameResult == timeModel.dayName) {
          await GetInstance.store
              .collection(timeModel.year)
              .doc(timeModel.month)
              .collection('$day')
              .doc('${abc[index]}-${clock[index]}')
              .set({
            'Name': name,
            'Phone': phone,
            'State': booked,
          });
        }
      }
    }
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Future removePinnedTimes(
    BuildContext context,
    TimeModel timeModel,
  ) async {
    for (int day = 1; day <= 31; day++) {
      for (var index = timeModel.start.toInt();
          index < timeModel.end.toInt();
          index++) {
        String dayNameResult = DateFormat('EEEE').format(
            DateTime.utc(timeModel.year.toInt(), timeModel.month.toInt(), day));

        if (dayNameResult == timeModel.dayName) {
          await GetInstance.store
              .collection(timeModel.year)
              .doc(timeModel.month)
              .collection('$day')
              .doc('${abc[index]}-${clock[index]}')
              .set(
            {
              'Name': '',
              'Phone': '',
              'State': '',
            },
          );
        }
      }
    }
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Future addNewYearToDatabase(
    BuildContext context,
    String year,
  ) async {
    var cubit = DatabaseYearsCubit.get(context);
    for (cubit.monthDB = 1; cubit.monthDB <= 12; cubit.monthDB++) {
      for (cubit.dayDB = 1; cubit.dayDB <= 31; cubit.dayDB++) {
        for (cubit.indexDB = 0; cubit.indexDB <= 23; cubit.indexDB++) {
          await GetInstance.store
              .collection(year)
              .doc('${cubit.monthDB}')
              .collection('${cubit.dayDB}')
              .doc('${abc[cubit.indexDB]}-${clock[cubit.indexDB]}')
              .set({
            'Name': '',
            'Phone': '',
            'State': '',
          });
          if (context.mounted) {
            cubit.progressCalculator();
          }
        }
      }
    }
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void changePrices(BuildContext context) {
    PricesCubit cubit = PricesCubit.get(context);
    GetInstance.store.collection('Control Panel').doc('Prices').set({
      'Day': int.tryParse(cubit.dayPriceController.text),
      'Night': int.tryParse(cubit.nightPriceController.text),
      'Night End AM': int.tryParse(cubit.to.text),
      'Night Start PM': int.tryParse(cubit.from.text),
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.racketFirstColor,
        content: Text(
          'Prices Changed',
          style: TextStyle(
            color: AppTheme.whiteTextColor,
          ),
        ),
      ),
    );
    NotificationService.sendGlobalNotification(
      title: 'Price Changed',
      body: 'Check our new prices',
    );
  }

  @override
  void addOffers(BuildContext context) {
    OffersCubit cubit = OffersCubit.get(context);
    GetInstance.store
        .collection('Offers')
        .doc(cubit.offerIDController.text)
        .set({
      'title': cubit.offerTitleController.text,
      'image': cubit.offerControllerImage.text,
      'fb': cubit.offerControllerLinkForFacebook.text,
      'ig': cubit.offerControllerLinkForInstagram.text,
      'id': cubit.offerIDController.text,
    });
    NotificationService.sendGlobalNotification(
      title: 'New Offer',
      body: 'Open to see our new offer',
    );
    cubit.offerControllerImage.clear();
    cubit.offerControllerLinkForFacebook.clear();
    cubit.offerControllerLinkForInstagram.clear();
    cubit.offerIDController.clear();
    cubit.offerTitleController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Offer Added',
          style: TextStyle(
            color: AppTheme.whiteTextColor,
          ),
        ),
        backgroundColor: AppTheme.racketFirstColor,
      ),
    );
  }

  @override
  Future logOut(BuildContext context) async {
    final prefs = await GetInstance.prefs;
    prefs.setBool(PrefsKeys.kIsLoggedIn, false);
    GetInstance.auth.signOut();
    if (context.mounted) {
      GetInstance.msg.unsubscribeFromTopic('notify');
      GetInstance.msg
          .unsubscribeFromTopic(prefs.getString(PrefsKeys.kFirebaseID)!);
      GetInstance.msg.unsubscribeFromTopic('offers');
      GetInstance.msg.unsubscribeFromTopic('newUsers');
      GetInstance.msg.unsubscribeFromTopic('0');
      Navigator.pop(context);
      Navigator.pushReplacementNamed(
        context,
        AuthView.id,
      );
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/features/auth/presentation/views/auth_view.dart';
import 'package:padel_club/features/home/data/repos/home_repo.dart';
import 'package:padel_club/features/home/presentation/view_models/home_cubit/home_cubit.dart';

class HomeRepoImpl extends HomeRepo {
  @override
  Future logOut(BuildContext context) async {
    final prefs = await GetInstance.prefs;
    prefs.setBool(PrefsKeys.kIsLoggedIn, false);
    GetInstance.auth.signOut();
    GetInstance.msg.unsubscribeFromTopic('notify');
    GetInstance.msg
        .unsubscribeFromTopic(prefs.getString(PrefsKeys.kFirebaseID)!);
    GetInstance.msg.unsubscribeFromTopic('offers');
    GetInstance.msg.unsubscribeFromTopic('newUsers');
    GetInstance.msg.unsubscribeFromTopic('0');

    if (context.mounted) {
      HomeCubit.get(context).mainPagesIndex = 0;
      Navigator.pop(context);
      Navigator.pushReplacementNamed(
        context,
        AuthView.id,
      );
    }
  }

  @override
  Future updateProfile(
      BuildContext context,
      TextEditingController profileNameController,
      TextEditingController profilePhoneController) async {
    final prefs = await GetInstance.prefs;
    prefs.setString(
      PrefsKeys.kName,
      profileNameController.text,
    );
    prefs.setString(
      PrefsKeys.kPhone,
      profilePhoneController.text,
    );
    GetInstance.store
        .collection('App Users')
        .doc(prefs.getString(PrefsKeys.kFirebaseID))
        .set(
            {
          'ID': prefs.getString(PrefsKeys.kFirebaseID),
          'Name': profileNameController.text,
          'Phone Number': profilePhoneController.text,
        },
            SetOptions(
              merge: true,
            ));

    if (context.mounted) {
      Navigator.pop(context);
      HomeCubit.get(context).changeName();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 1500),
          backgroundColor: AppTheme.racketFirstColor,
          content: Text(
            'Updated Successfully',
            style: TextStyle(color: AppTheme.whiteTextColor),
          ),
        ),
      );
    }
  }
}

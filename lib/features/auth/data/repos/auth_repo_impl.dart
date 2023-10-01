import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/services/notifications.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/core/widgets/no_internet_snackbar.dart';
import 'package:padel_club/features/auth/data/repos/auth_repo.dart';
import 'package:padel_club/features/auth/presentation/view_models/auth_cubit/auth_cubit.dart';
import 'package:padel_club/features/home/presentation/views/home_view.dart';

class AuthRepoImpl extends AuthRepo {
  @override
  Future logInForAdmin(
    BuildContext context,
    AsyncSnapshot snapshot,
    TextEditingController adminPhone,
    TextEditingController adminPassword,
  ) async {
    AuthCubit cubit = AuthCubit.get(context);
    bool wrongData = false;
    String phoneNumber = adminPhone.text;
    String lock = adminPassword.text;

    try {
      if (cubit.adminFormKey.currentState!.validate()) {
        cubit.buttonIsLoading(true);
        if (cubit.isLoading) {
          String phone1,
              pass1,
              name1,
              phone2,
              pass2,
              name2,
              phone3,
              pass3,
              name3,
              phone4,
              pass4,
              name4,
              phone5,
              name5,
              pass5;
          phone1 = snapshot.data!.docs[0]['phone'];
          phone2 = snapshot.data!.docs[1]['phone'];
          phone3 = snapshot.data!.docs[2]['phone'];
          phone4 = snapshot.data!.docs[3]['phone'];
          phone5 = snapshot.data!.docs[4]['phone'];
          name1 = snapshot.data!.docs[0]['name'];
          name2 = snapshot.data!.docs[1]['name'];
          name3 = snapshot.data!.docs[2]['name'];
          name4 = snapshot.data!.docs[3]['name'];
          name5 = snapshot.data!.docs[4]['name'];
          pass1 = snapshot.data!.docs[0]['pass'];
          pass2 = snapshot.data!.docs[1]['pass'];
          pass3 = snapshot.data!.docs[2]['pass'];
          pass4 = snapshot.data!.docs[3]['pass'];
          pass5 = snapshot.data!.docs[4]['pass'];
          final prefs = await GetInstance.prefs;
          if ((phoneNumber == phone1 && lock == pass1) ||
              (phoneNumber == phone2 && lock == pass2) ||
              (phoneNumber == phone3 && lock == pass3) ||
              (phoneNumber == phone4 && lock == pass4) ||
              (phoneNumber == phone5 && lock == pass5)) {
            if (phoneNumber == phone1) {
              prefs.setString(PrefsKeys.kName, name1);
              prefs.setString(PrefsKeys.kPhone, phoneNumber);
            } else if (phoneNumber == phone2) {
              prefs.setString(PrefsKeys.kName, name2);
              prefs.setString(PrefsKeys.kPhone, phoneNumber);
            } else if (phoneNumber == phone3) {
              prefs.setString(PrefsKeys.kName, name3);
              prefs.setString(PrefsKeys.kPhone, phoneNumber);
            } else if (phoneNumber == phone4) {
              prefs.setString(PrefsKeys.kName, name4);
              prefs.setString(PrefsKeys.kPhone, phoneNumber);
            } else if (phoneNumber == phone5) {
              prefs.setString(PrefsKeys.kName, name5);
              prefs.setString(PrefsKeys.kPhone, phoneNumber);
            }
            prefs.setBool(PrefsKeys.kIsLoggedIn, true);
            prefs.setBool(PrefsKeys.kAdmin, true);
            prefs.setString(PrefsKeys.kFirebaseID, '0');
            await GetInstance.auth.signInAnonymously();
            await GetInstance.msg.subscribeToTopic('notify');
            await GetInstance.msg.subscribeToTopic('newUsers');
            await GetInstance.msg.subscribeToTopic('0');
            if (context.mounted) {
              Navigator.pushReplacementNamed(
                context,
                HomeView.id,
              );
              cubit.buttonIsLoading(false);
            }
          } else {
            throw Exception(wrongData = true);
          }
        }
      }
    } catch (e) {
      if (wrongData == true) {
        await Future.delayed(const Duration(milliseconds: 500));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(milliseconds: 1500),
              backgroundColor: const Color.fromRGBO(244, 67, 54, 1),
              content: Text(
                'wrong phone or password please try again',
                style: TextStyle(color: AppTheme.whiteTextColor),
              ),
            ),
          );
        }
      } else {
        if (context.mounted) {
          noInternetSnackBar(context);
        }
      }
      if (context.mounted) {
        cubit.buttonIsLoading(false);
      }
    }
  }

  @override
  Future logInForUser(
    BuildContext context,
  ) async {
    AuthCubit cubit = AuthCubit.get(context);
    if (cubit.userFormKey.currentState!.validate()) {
      if (!cubit.isLoading) {
        AuthCubit.get(context).buttonIsLoading(true);
        try {
          final prefs = await GetInstance.prefs;
          UserCredential user = await GetInstance.auth.signInAnonymously();
          prefs.setString(PrefsKeys.kName, cubit.userName.text);
          prefs.setString(PrefsKeys.kPhone, cubit.userPhone.text);
          prefs.setBool(PrefsKeys.kAdmin, false);
          prefs.setBool(PrefsKeys.kIsLoggedIn, true);
          prefs.setString(PrefsKeys.kFirebaseID, user.user!.uid);
          await NotificationService.sendNewUserNotification(
            name: cubit.userName.text,
          );
          await GetInstance.store
              .collection('App Users')
              .doc(user.user!.uid)
              .set(
                  {
                'ID': user.user!.uid,
                'Name': cubit.userName.text,
                'Phone Number': cubit.userPhone.text,
                'Last Message': DateTime.now(),
                'Message': '',
              },
                  SetOptions(
                    merge: true,
                  ));
          await GetInstance.msg.subscribeToTopic(user.user!.uid);
          await GetInstance.msg.subscribeToTopic('offers');
          if (context.mounted) {
            Navigator.pushReplacementNamed(
              context,
              HomeView.id,
            );
            cubit.buttonIsLoading(false);
          }
        } catch (e) {
          if (context.mounted) {
            cubit.buttonIsLoading(false);
            noInternetSnackBar(context);
          }
        }
      }
    }
  }
}

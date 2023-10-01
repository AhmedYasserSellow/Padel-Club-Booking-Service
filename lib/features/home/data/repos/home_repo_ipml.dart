import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/services/notifications.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/core/widgets/no_internet_snackbar.dart';
import 'package:padel_club/features/auth/presentation/views/auth_view.dart';
import 'package:padel_club/features/home/data/models/booking_service_model.dart';
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
  Future confirmBooking(
      BuildContext context, BookingServiceModel bookingServiceModel) async {
    bool connectionState = await connection.hasConnection;
    if (connectionState == false) {
      if (context.mounted) {
        noInternetSnackBar(context);
      }
    } else {
      GetInstance.store
          .collection(bookingServiceModel.firebaseModel.selectedYear)
          .doc(bookingServiceModel.firebaseModel.selectedMonth)
          .collection(bookingServiceModel.firebaseModel.selectedDay)
          .doc(
              '${abc[bookingServiceModel.index]}-${clock[bookingServiceModel.index]}')
          .set({
        'State': booked,
      }, SetOptions(merge: true));
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Future cancelBooking(
      BuildContext context, BookingServiceModel bookingServiceModel) async {
    bool connectionState = await connection.hasConnection;
    if (connectionState == false) {
      if (context.mounted) {
        noInternetSnackBar(context);
      }
    } else {
      GetInstance.store
          .collection(bookingServiceModel.firebaseModel.selectedYear)
          .doc(bookingServiceModel.firebaseModel.selectedMonth)
          .collection(bookingServiceModel.firebaseModel.selectedDay)
          .doc(
              '${abc[bookingServiceModel.index]}-${clock[bookingServiceModel.index]}')
          .set({
        'Name': '',
        'Phone': '',
        'State': '',
      }, SetOptions(merge: true));
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Future addNewBook(
      BuildContext context,
      BookingServiceModel bookingServiceModel,
      bool manager,
      TextEditingController nameController,
      TextEditingController phoneNumberController,
      String myID) async {
    if (manager) {
      GetInstance.store
          .collection(bookingServiceModel.firebaseModel.selectedYear)
          .doc(bookingServiceModel.firebaseModel.selectedMonth)
          .collection(bookingServiceModel.firebaseModel.selectedDay)
          .doc(
              '${abc[bookingServiceModel.index]}-${clock[bookingServiceModel.index]}')
          .set({
        'Name': nameController.text,
        'Phone': phoneNumberController.text,
        'State': booked,
      });
    } else {
      GetInstance.store
          .collection(bookingServiceModel.firebaseModel.selectedYear)
          .doc(bookingServiceModel.firebaseModel.selectedMonth)
          .collection(bookingServiceModel.firebaseModel.selectedDay)
          .doc(
              '${abc[bookingServiceModel.index]}-${clock[bookingServiceModel.index]}')
          .set({
        'Name': nameController.text,
        'Phone': phoneNumberController.text,
        'State': pending,
        'Created at': DateTime.now(),
      });

      NotificationService.sendNotify(
        id: '${bookingServiceModel.firebaseModel.selectedDay}${bookingServiceModel.firebaseModel.selectedMonth}${bookingServiceModel.firebaseModel.selectedYear}${clock[bookingServiceModel.index]}',
        title: nameController.text,
        body:
            'Date : ${bookingServiceModel.firebaseModel.selectedDay}/${bookingServiceModel.firebaseModel.selectedMonth}/${bookingServiceModel.firebaseModel.selectedYear} \nTime : ${clock[bookingServiceModel.index]}',
      );
      GetInstance.store.collection('Chats').doc('0').collection(myID).add({
        'Message':
            'I have send a book request\nDate : ${bookingServiceModel.firebaseModel.selectedDay}/${bookingServiceModel.firebaseModel.selectedMonth}/${bookingServiceModel.firebaseModel.selectedYear} \nTime : ${clock[bookingServiceModel.index]}',
        'ID': myID,
        'Created at': DateTime.now(),
      });
      GetInstance.store.collection('App Users').doc(myID).set(
          {
            'Last Message': DateTime.now(),
            'Message':
                'I have send a book request\nDate : ${bookingServiceModel.firebaseModel.selectedDay}/${bookingServiceModel.firebaseModel.selectedMonth}/${bookingServiceModel.firebaseModel.selectedYear} \nTime : ${clock[bookingServiceModel.index]}',
          },
          SetOptions(
            merge: true,
          ));
    }
    if (context.mounted) {
      Navigator.pop(context);
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

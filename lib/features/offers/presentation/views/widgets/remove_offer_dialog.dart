import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/core/widgets/back_button.dart';

class RemoveOfferDialog extends StatelessWidget {
  const RemoveOfferDialog({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text(
        '\nAre you sure you want to delete this offer ?',
        style: TextStyle(fontSize: 20),
      ),
      actions: [
        const MyBackButton(),
        TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateColor.resolveWith(
                  (states) => AppTheme.bookedColor)),
          child: Text(
            'Delete',
            style: TextStyle(color: AppTheme.whiteTextColor),
          ),
          onPressed: () {
            Navigator.pop(context);
            GetInstance.store.collection('Offers').doc(id).delete();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

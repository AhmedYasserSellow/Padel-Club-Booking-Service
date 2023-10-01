import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';

class NotificationListTileView extends StatelessWidget {
  const NotificationListTileView({
    super.key,
    required this.snapshot,
    required this.index,
  });
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;
  final int index;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        snapshot.data!.docs[index]['title'],
        style: TextStyle(
          color: AppTheme.whiteTextColor,
        ),
      ),
      subtitle: Text(
        snapshot.data!.docs[index]['body'],
        style: TextStyle(
          color: AppTheme.whiteTextColor,
        ),
      ),
      trailing: IconButton(
          onPressed: () {
            FirebaseFirestore.instance
                .collection('Notifications')
                .doc(snapshot.data!.docs[index].id)
                .delete();
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          )),
    );
  }
}

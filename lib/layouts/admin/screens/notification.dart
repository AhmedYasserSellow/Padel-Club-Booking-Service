import 'package:booking/core/utilities/theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('Notifications').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'There is no Notifications',
                  style: TextStyle(
                    color: whiteTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
              );
            } else {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return NotificationListTile(
                    snapshot: snapshot,
                    index: index,
                  );
                },
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class NotificationListTile extends StatelessWidget {
  const NotificationListTile({
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
          color: whiteTextColor,
        ),
      ),
      subtitle: Text(
        snapshot.data!.docs[index]['body'],
        style: TextStyle(
          color: whiteTextColor,
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

import 'package:booking/components/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  static String id = 'Notification Screen';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [racketFirstColor, racketSecondColor],
        ),
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Notifications')
              .snapshots(),
          builder: (context, snapshot) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: BackButton(
                  color: textColor,
                ),
                title: Text(
                  'Notifications',
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
                centerTitle: true,
              ),
              body: snapshot.hasData
                  ? snapshot.data!.docs.isEmpty
                      ? Center(
                          child: Text(
                            'There is no Notifications',
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                snapshot.data!.docs[index]['title'],
                                style: TextStyle(
                                  color: textColor,
                                ),
                              ),
                              subtitle: Text(
                                snapshot.data!.docs[index]['body'],
                                style: TextStyle(
                                  color: textColor,
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
                          })
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            );
          }),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/core/widgets/loading_indicator.dart';
import 'package:padel_club/features/home/presentation/view_models/home_cubit/home_cubit.dart';
import 'package:padel_club/features/chat/presentation/views/chat_view.dart';
import 'package:padel_club/features/chat/presentation/views/widgets/no_users_view.dart';

class SelectChatView extends StatelessWidget {
  const SelectChatView({
    super.key,
    required this.manager,
    required this.myName,
    required this.firebaseID,
  });
  final bool manager;
  final String myName;
  final String firebaseID;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: GetInstance.store
            .collection('App Users')
            .orderBy(
              'Last Message',
              descending: true,
            )
            .snapshots(),
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>> users =
                userSnapshot.data!.docs;

            if (users.isNotEmpty) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  String id = users[index]['sender ID'];
                  return ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: HomeCubit.get(context).iconAndTextColor,
                    ),
                    title: Text(users[index]['Name']),
                    subtitle: Text(
                      id == '0'
                          ? 'you: ${users[index]['Message']}'
                          : users[index]['Message'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ChatView(
                              manager: manager,
                              name: users[index]['Name'],
                              id: users[index]['ID'],
                            );
                          },
                        ));
                      },
                      icon: Icon(
                        Icons.messenger_outline,
                        color: HomeCubit.get(context).iconAndTextColor,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                itemCount: users.length,
              );
            } else {
              return const NoUsersView();
            }
          } else {
            return const Center(
              child: LoadingIndicator(),
            );
          }
        });
  }
}

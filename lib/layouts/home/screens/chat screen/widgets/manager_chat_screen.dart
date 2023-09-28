import 'package:booking/layouts/home/logic/home_cubit.dart';
import 'package:booking/layouts/home/screens/chat%20screen/widgets/no_users_screen.dart';
import 'package:booking/layouts/home/screens/chat%20screen/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({
    super.key,
    required this.manager,
    required this.myName,
  });
  final bool manager;
  final String myName;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
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
                  return ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: HomeCubit.get(context).iconAndTextColor,
                    ),
                    title: Text(users[index]['Name']),
                    subtitle: Text(
                      users[index]['Message'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ChatScreen(
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
              return const NoUsersScreen();
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

import 'package:booking/bloc/cubit.dart';
import 'package:booking/components/constants.dart';
import 'package:booking/components/theme.dart';
import 'package:booking/components/widgets/default_button.dart';
import 'package:booking/screens/chat%20screen/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            if (manager) {
              if (users.isNotEmpty) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        color: AppCubit.get(context).iconAndTextColor,
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
                                myName: myName,
                                manager: manager,
                                name: users[index]['Name'],
                                id: users[index]['ID'],
                              );
                            },
                          ));
                        },
                        icon: Icon(
                          Icons.messenger_outline,
                          color: AppCubit.get(context).iconAndTextColor,
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
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage(
                            AppCubit.get(context).brightness == Brightness.light
                                ? 'assets/no_offer.png'
                                : 'assets/no_offer_dark_mode.png',
                          ),
                          width: MediaQuery.of(context).size.width / 2,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'There is no users right now',
                          style: TextStyle(
                            color: AppCubit.get(context).iconAndTextColor,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            } else {
              return Center(
                child: defaultButton(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    String myID = prefs.getString(id)!;
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            myName: myName,
                            name: 'Players Service',
                            id: myID,
                            manager: manager,
                          ),
                        ),
                      );
                    }
                  },
                  text: 'Open Chat',
                  color: racketFirstColor,
                  width: MediaQuery.of(context).size.width / 2,
                ),
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

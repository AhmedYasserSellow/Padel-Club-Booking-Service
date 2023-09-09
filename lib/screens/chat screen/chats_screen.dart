import 'package:booking/bloc/cubit.dart';
import 'package:booking/components/constants.dart';
import 'package:booking/screens/chat%20screen/chat_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({
    super.key,
    required this.manager,
    required this.managerID,
  });
  final bool manager;
  final String managerID;
  @override
  Widget build(BuildContext context) {
    if (manager) {
      return StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('App Users').snapshots(),
          builder: (context, usersSnapshot) {
            if (usersSnapshot.hasData) {
              List<QueryDocumentSnapshot<Map<String, dynamic>>> users =
                  usersSnapshot.data!.docs;
              return ListView.separated(
                itemBuilder: (context, index) {
                  return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Chats')
                          .doc(managerID.replaceAll(' ', ''))
                          .collection(users[index].id)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.docs.isEmpty) {
                            return const SizedBox();
                          } else {
                            return ListTile(
                              leading: Icon(
                                Icons.account_circle,
                                color: AppCubit.get(context).iconAndTextColor,
                              ),
                              title: Text(users[index]['Name']),
                              subtitle: Text(
                                users[index]['Phone Number'],
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return ChatScreen(
                                        manager: manager,
                                        name: users[index]['Name'],
                                        managerID: managerID,
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
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      });
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                itemCount: users.length,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          });
    } else {
      return StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Chats').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: snapshot.data!.docs[index]['Image'],
                        height: 50,
                        width: 50,
                      ),
                    ),
                    subtitle: Text(
                      snapshot.data!.docs[index]['Phone'],
                    ),
                    trailing: IconButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.getString(id);
                          if (context.mounted) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ChatScreen(
                                manager: manager,
                                id: prefs.getString(id)!,
                                name: snapshot.data!.docs[index]['Name'],
                                managerID: snapshot.data!.docs[index].id,
                              );
                            }));
                          }
                        },
                        icon: Icon(
                          Icons.messenger_outline,
                          color: AppCubit.get(context).iconAndTextColor,
                        )),
                    title: Text(
                      snapshot.data!.docs[index]['Name'],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          });
    }
  }
}

import 'package:booking/logic/cubit.dart';
import 'package:booking/core/constants/constants.dart';
import 'package:booking/core/services/notifications.dart';
import 'package:booking/core/widgets/text_form_field.dart';
import 'package:booking/layouts/home/screens/chat%20screen/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({
    super.key,
    required this.name,
    required this.id,
    required this.manager,
  });

  final String name;

  final String id;
  final bool manager;
  final TextEditingController controller = TextEditingController();
  final ScrollController listController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Chats')
            .doc('0')
            .collection(id)
            .orderBy(
              'Created at',
              descending: true,
            )
            .snapshots(),
        builder: (context, snapshot) {
          return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: manager
                  ? AppBar(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      scrolledUnderElevation: 0,
                      elevation: 0,
                      centerTitle: true,
                      leading: BackButton(
                        onPressed: () {
                          AppCubit.get(context).navigateToMainPages(context, 0);
                        },
                        color: AppCubit.get(context).iconAndTextColor,
                      ),
                      title: Text(
                        name,
                        style: TextStyle(
                            color: AppCubit.get(context).iconAndTextColor),
                      ),
                    )
                  : const PreferredSize(
                      preferredSize: Size(0, 0),
                      child: SizedBox(),
                    ),
              body: Column(
                children: [
                  snapshot.hasData
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 16,
                              right: 16,
                              left: 16,
                            ),
                            child: ListView.separated(
                              controller: listController,
                              reverse: true,
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 15,
                                );
                              },
                              itemBuilder: (context, index) {
                                String requiredID;
                                if (manager) {
                                  requiredID = '0';
                                } else {
                                  requiredID = id;
                                }
                                // DateTime date =
                                //     DateTime.fromMicrosecondsSinceEpoch(snapshot
                                //         .data!
                                //         .docs[index]['Created at']
                                //         .microsecondsSinceEpoch);
                                // print(date.hour);
                                return ChatBubble(
                                  message: snapshot.data!.docs[index]
                                      ['Message'],
                                  myMessage: snapshot.data!.docs[index]['ID'] ==
                                          requiredID
                                      ? true
                                      : false,
                                );
                              },
                              itemCount: snapshot.data!.docs.length,
                            ),
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                    child: Form(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: myTextFormField(
                              maxLines: 3,
                              controller: controller,
                              type: TextInputType.multiline,
                              validate: (String? value) {},
                              label: 'Message',
                              prefix: Icons.message,
                              context: context,
                              color: AppCubit.get(context).iconAndTextColor,
                              textStyleColor:
                                  AppCubit.get(context).iconAndTextColor,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                              onPressed: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                String myName = prefs.getString(yourName)!;
                                if (controller.text != '') {
                                  FirebaseFirestore.instance
                                      .collection('Chats')
                                      .doc('0')
                                      .collection(id)
                                      .add({
                                    'Message': controller.text,
                                    'ID': manager ? '0' : id,
                                    'Created at': DateTime.now(),
                                  });
                                  FirebaseFirestore.instance
                                      .collection('App Users')
                                      .doc(id)
                                      .set(
                                          {
                                        'Last Message': DateTime.now(),
                                        'Message': controller.text,
                                      },
                                          SetOptions(
                                            merge: true,
                                          ));
                                  sendMessageNotification(
                                    title: manager ? 'Players Service' : myName,
                                    body: controller.text,
                                    reciverID: manager ? id : '0',
                                  );
                                  controller.clear();
                                  listController.jumpTo(
                                    0,
                                  );
                                }
                              },
                              icon: Icon(
                                Icons.send_outlined,
                                color: AppCubit.get(context).iconAndTextColor,
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}

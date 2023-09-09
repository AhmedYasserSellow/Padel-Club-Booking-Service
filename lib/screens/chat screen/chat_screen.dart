import 'package:booking/bloc/cubit.dart';
import 'package:booking/components/notifications.dart';
import 'package:booking/components/widgets/text_form_field.dart';
import 'package:booking/screens/chat%20screen/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({
    super.key,
    required this.name,
    required this.id,
    required this.manager,
    required this.myName,
  });

  final String? name;
  final String myName;
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
              appBar: AppBar(
                centerTitle: true,
                leading: BackButton(
                  color: AppCubit.get(context).iconAndTextColor,
                ),
                title: Text(
                  name!,
                  style:
                      TextStyle(color: AppCubit.get(context).iconAndTextColor),
                ),
              ),
              body: Column(
                children: [
                  snapshot.hasData
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
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
                  BottomAppBar(
                    elevation: 0,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Form(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: myTextFormField(
                              controller: controller,
                              type: TextInputType.text,
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
                              onPressed: () {
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

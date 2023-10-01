import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/core/widgets/text_form_field.dart';
import 'package:padel_club/features/home/presentation/view_models/home_cubit/home_cubit.dart';
import 'package:padel_club/features/home/presentation/views/widgets/chat_bubble.dart';

class ChatView extends StatelessWidget {
  ChatView({
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
        stream: GetInstance.store
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
                          Navigator.pop(context);
                        },
                        color: HomeCubit.get(context).iconAndTextColor,
                      ),
                      title: Text(
                        name,
                        style: TextStyle(
                          color: HomeCubit.get(context).iconAndTextColor,
                        ),
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
                              color: HomeCubit.get(context).iconAndTextColor,
                              textStyleColor:
                                  HomeCubit.get(context).iconAndTextColor,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                              onPressed: () async {
                                HomeCubit.get(context).sendMessage(
                                    controller, manager, id, listController);
                              },
                              icon: Icon(
                                Icons.send_outlined,
                                color: HomeCubit.get(context).iconAndTextColor,
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

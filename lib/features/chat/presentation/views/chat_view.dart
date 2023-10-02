import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/core/widgets/loading_indicator.dart';
import 'package:padel_club/core/widgets/text_form_field.dart';
import 'package:padel_club/features/chat/data/models/chat_message_model.dart';
import 'package:padel_club/features/chat/presentation/view_models/chat_cubit/chat_cubit.dart';
import 'package:padel_club/features/chat/presentation/views/widgets/chat_bubble.dart';
import 'package:padel_club/features/home/presentation/view_models/home_cubit/home_cubit.dart';

class ChatView extends StatelessWidget {
  const ChatView({
    super.key,
    required this.name,
    required this.id,
    required this.manager,
  });

  final String name;
  final String id;
  final bool manager;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
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
                ChatCubit cubit = ChatCubit.get(context);
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
                                    controller: cubit.listController,
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
                                        chatMessageModel: ChatMessageModel(
                                          message: snapshot.data!.docs[index]
                                              ['Message'],
                                          isMyMessage: snapshot.data!
                                                      .docs[index]['ID'] ==
                                                  requiredID
                                              ? true
                                              : false,
                                        ),
                                      );
                                    },
                                    itemCount: snapshot.data!.docs.length,
                                  ),
                                ),
                              )
                            : const Center(
                                child: LoadingIndicator(),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 12),
                          child: Form(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: myTextFormField(
                                    maxLines: 3,
                                    controller: cubit.controller,
                                    type: TextInputType.multiline,
                                    validate: (String? value) {},
                                    label: 'Message',
                                    prefix: Icons.message,
                                    context: context,
                                    color:
                                        HomeCubit.get(context).iconAndTextColor,
                                    textStyleColor:
                                        HomeCubit.get(context).iconAndTextColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                    onPressed: () async {
                                      ChatCubit.get(context).sendMessage(
                                        manager,
                                        id,
                                      );
                                    },
                                    icon: Icon(
                                      Icons.send_outlined,
                                      color: HomeCubit.get(context)
                                          .iconAndTextColor,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ));
              });
        },
      ),
    );
  }
}

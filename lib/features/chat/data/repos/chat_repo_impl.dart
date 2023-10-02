import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/constants/constants.dart';
import 'package:padel_club/core/utilities/services/notifications.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';
import 'package:padel_club/features/chat/data/repos/chat_repo.dart';

class ChatRepoImpl extends ChatRepo {
  @override
  Future sendMessage(
    TextEditingController textController,
    bool manager,
    String id,
    ScrollController listController,
  ) async {
    final prefs = await GetInstance.prefs;
    String myName = prefs.getString(PrefsKeys.kName)!;
    if (textController.text != '') {
      GetInstance.store.collection('Chats').doc('0').collection(id).add({
        'Message': textController.text,
        'ID': manager ? '0' : id,
        'Created at': DateTime.now(),
      });
      GetInstance.store.collection('App Users').doc(id).set(
          {
            'Last Message': DateTime.now(),
            'Message': textController.text,
          },
          SetOptions(
            merge: true,
          ));
      NotificationService.sendMessageNotification(
        title: manager ? 'Players Service' : myName,
        body: textController.text,
        reciverID: manager ? id : '0',
      );
      textController.clear();
      listController.jumpTo(
        0,
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:padel_club/core/utilities/theme/theme.dart';
import 'package:padel_club/features/chat/data/models/chat_message_model.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.chatMessageModel,
  });
  final ChatMessageModel chatMessageModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: chatMessageModel.isMyMessage
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 3 / 4,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: !chatMessageModel.isMyMessage
              ? AppTheme.racketFirstColor
              : AppTheme.racketSecondColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(chatMessageModel.isMyMessage ? 16 : 0),
            bottomRight: Radius.circular(chatMessageModel.isMyMessage ? 0 : 16),
          ),
        ),
        child: Text(
          chatMessageModel.message,
          style: TextStyle(color: AppTheme.whiteTextColor),
        ),
      ),
    );
  }
}

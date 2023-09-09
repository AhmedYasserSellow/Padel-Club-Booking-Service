import 'package:booking/components/theme.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.myMessage,
  });
  final String message;
  final bool myMessage;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: myMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 3 / 4,
        ),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: !myMessage ? racketFirstColor : racketSecondColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(myMessage ? 16 : 0),
            bottomRight: Radius.circular(myMessage ? 0 : 16),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}

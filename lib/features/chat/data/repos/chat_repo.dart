import 'package:flutter/material.dart';

abstract class ChatRepo {
  Future sendMessage(
    TextEditingController textController,
    bool manager,
    String id,
    ScrollController listController,
  );
}

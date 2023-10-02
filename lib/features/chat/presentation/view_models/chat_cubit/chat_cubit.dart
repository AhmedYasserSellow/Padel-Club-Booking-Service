import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:padel_club/core/utilities/services/service_locator.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);

  final TextEditingController controller = TextEditingController();
  final ScrollController listController = ScrollController();

  Future sendMessage(
    bool manager,
    String id,
  ) async {
    GetInstance.chatRepoImpl
        .sendMessage(controller, manager, id, listController);
  }
}

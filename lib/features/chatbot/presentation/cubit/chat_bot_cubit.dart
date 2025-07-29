import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/chat_message.dart';
import '../../domain/repo/chat_repo.dart';

class ChatCubit extends Cubit<List<ChatMessage>> {
  final ChatRepository chatRepository;

  ChatCubit(this.chatRepository) : super([]) {
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    emit([
      ChatMessage(message: "👋 Welcome to Bingo ChatBot!", isFromUser: false),
    ]);
  }

  void sendMessage(String message) async {
    final updated = List<ChatMessage>.from(state)
      ..add(ChatMessage(message: message, isFromUser: true));
    emit(updated);

    try {
      final response = await chatRepository.sendMessage(message);
      emit([...updated, ChatMessage(message: response, isFromUser: false)]);
    } catch (e) {
      emit([
        ...updated,
        ChatMessage(message: "Error: ${e.toString()}", isFromUser: false),
      ]);
    }
  }
}

import '../repo/chat_repo.dart';

class ChatMessageUsecase {
  final ChatRepository _chatRepository;

  ChatMessageUsecase(this._chatRepository);

  Future<String> call(String message) async =>
      await _chatRepository.sendMessage(message);
}

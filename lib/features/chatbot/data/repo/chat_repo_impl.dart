import 'package:bingo/features/chatbot/data/datasource/chat_bot_datasource.dart';
import 'package:bingo/features/chatbot/domain/repo/chat_repo.dart';

class ChatRepoImpl implements ChatRepository {
  late ChatBotDatasource chatBotDatasource;

  ChatRepoImpl(this.chatBotDatasource);

  @override
  Future<String> sendMessage(String message) async {
    return await chatBotDatasource.sendMessage(message);
  }
}

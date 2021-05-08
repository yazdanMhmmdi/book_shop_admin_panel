
import 'package:book_shop_admin_panel/data/model/chat_model.dart';
import 'package:book_shop_admin_panel/networking/api_provider.dart';

class ChatRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<ChatModel> getChatMessages(
      String user_id, String book_id) async {
    final response = await _apiProvider.get(
        '/admin_get_chatMessages_api.php?user_id=${user_id}&book_id=${book_id}');
    return ChatModel.fromJson(response);
  }

}

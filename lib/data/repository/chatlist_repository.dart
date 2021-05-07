import 'package:book_shop_admin_panel/data/model/chatList_model.dart';
import 'package:book_shop_admin_panel/networking/api_provider.dart';

class ChatlistRepository {
  ApiProvider _apiProvider = new ApiProvider();
  Future<ChatListModel> getChatList(String user_id, String page) async {
    final response = await _apiProvider
        .get("admin_get_chatList.php?user_id=${user_id}&page=${page}");
    return ChatListModel.fromJson(response);
  }
}
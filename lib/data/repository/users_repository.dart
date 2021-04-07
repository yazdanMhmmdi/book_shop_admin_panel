import 'package:book_shop_admin_panel/data/model/category_model.dart';
import 'package:book_shop_admin_panel/data/model/users_model.dart';
import 'package:book_shop_admin_panel/networking/api_provider.dart';
import 'package:http/http.dart';

class UsersRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<UsersModel> getUsers(String page) async {
    final response = await _apiProvider.get("admin_get_users.php?page=${page}");
    return UsersModel.fromJson(response);
  }
}

import 'package:book_shop_admin_panel/data/model/login_model.dart';
import 'package:book_shop_admin_panel/networking/api_provider.dart';

class LoginRepository {
  ApiProvider _apiProvider = new ApiProvider();
  Future<LoginModel> login(String username, String password) async {
    final response = await _apiProvider
        .get("admin_login.php?username=${username}&password=${password}");
    return LoginModel.fromJson(response);
  }
}

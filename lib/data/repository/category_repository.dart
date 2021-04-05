import 'package:book_shop_admin_panel/data/model/category_model.dart';
import 'package:book_shop_admin_panel/networking/api_provider.dart';
import 'package:http/http.dart';

class CategoryRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<CategoryModel> getBooksCategory(
      String page, String category_id) async {
    final response = await _apiProvider
        .get("admin_get_books.php?page=${page}&category_id=${category_id}");
    return CategoryModel.fromJson(response);
  }
}

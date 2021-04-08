import 'package:book_shop_admin_panel/data/model/booksfunc_model.dart';
import 'package:book_shop_admin_panel/networking/api_provider.dart';
import 'package:http/http.dart';

class BooksFuncRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<BooksFuncModel> deleteBook(String book_id) async {
    final response = await _apiProvider.get(
        "http://localhost/book_shop/api/admin/admin_delete_books.php?book_id=${book_id}");
    return BooksFuncModel.fromJson(response);
  }
}

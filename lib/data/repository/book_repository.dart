import 'package:book_shop_admin_panel/data/model/book_model.dart';
import 'package:book_shop_admin_panel/networking/api_provider.dart';
import 'package:book_shop_admin_panel/data/model/bookfunc_model.dart';

import 'package:http/http.dart';

class BookRepository {
  ApiProvider _apiProvider = new ApiProvider();

  Future<BookModel> getBooks(String page, String category_id) async {
    final response = await _apiProvider
        .get("admin_get_books.php?page=${page}&category_id=${category_id}");
    return BookModel.fromJson(response);
  }

  Future<BookfuncModel> deleteBook(String book_id) async {
    final response =
        await _apiProvider.get("admin_delete_books.php?book_id=${book_id}");
    return BookfuncModel.fromJson(response);
  }
}

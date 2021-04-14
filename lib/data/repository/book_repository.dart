import 'dart:io';

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

  Future<BookfuncModel> addBook(
      {File file,
      String name,
      String language,
      String description,
      String coverType,
      String pageCount,
      String category_id,
      String vote,
      String writer}) async {
    Map<String, String> params = {
      'name': '${name}',
      'language': "${language}",
      'description': "${description}",
      'cover_type': "${coverType}",
      'pages_count': '${pageCount}',
      'category_id': '${category_id}',
      'vote_count': "${vote}",
      'writer': "${writer}",
    };

    final response =
        await _apiProvider.post('admin_add_books.php', file, params);
    return BookfuncModel.fromJson(response);
  }

  Future<BookfuncModel> editBook(
      {File file,
      String name,
      String language,
      String description,
      String coverType,
      String pageCount,
      String book_id,
      String vote,
      String writer}) async {
    Map<String, String> params = {
      'name': '${name}',
      'language': "${language}",
      'description': "${description}",
      'cover_type': "${coverType}",
      'pages_count': '${pageCount}',
      'book_id': '${book_id}',
      'vote_count': "${vote}",
      'writer': "${writer}",
    };
    var response;
    if (file != null) {
      response = await _apiProvider.post('admin_edit_books.php', file, params);
    } else {
      response =
          await _apiProvider.postWithNoFile('admin_edit_books.php', params);
    }
    return BookfuncModel.fromJson(response);
  }

  Future<BookModel> searcBook(
      {String search, String category_id, String page}) async {
    final response = await _apiProvider.get(
        "admin_search_books.php?category_id=${category_id}&search=${search}&page=${page}");
    return BookModel.fromJson(response);
  }
}

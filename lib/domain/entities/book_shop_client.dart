import 'dart:io';

import 'package:book_shop_admin_panel/data/models/book_model.dart';
import 'package:book_shop_admin_panel/data/models/books_list_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../core/constants/constants.dart';
import '../../data/models/function_response_model.dart';

part 'book_shop_client.g.dart';

@RestApi(baseUrl: kAdminApiUrl)
abstract class BookShopClient {
  factory BookShopClient(Dio dio, {String baseUrl}) = _BookShopClient;

  // @GET('/home_api.php?username=sss')
  // Future<HttpResponse<HomeModel>> fetchHome();

  @GET('/admin_get_books.php')
  Future<HttpResponse<BooksListModel>> fetchBooks(
      {@Query("page") required String page,
      @Query("category_id") required String categoryId});

  @POST('/admin_edit_books.php')
  @MultiPart()
  Future<HttpResponse<FunctionResponseModel>> editBooks({
    @Part(name: "book_id") required String bookId,
    @Part(name: "name") required String name,
    @Part(name: "writer") required String writer,
    @Part(name: "description") required String description,
    @Part(name: "language") required String language,
    @Part(name: "cover_type") required String coverType,
    @Part(name: "pages_count") required String pagesCount,
    @Part(name: "vote_count") required String voteCount,
    @Part(name: "picture") required File picture,
  });

  @POST('/admin_add_books.php')
  @MultiPart()
  Future<HttpResponse<FunctionResponseModel>> addBooks({
    @Part(name: "category_id") required String categoryId,
    @Part(name: "name") required String name,
    @Part(name: "writer") required String writer,
    @Part(name: "description") required String description,
    @Part(name: "language") required String language,
    @Part(name: "cover_type") required String coverType,
    @Part(name: "pages_count") required String pagesCount,
    @Part(name: "vote_count") required String voteCount,
    @Part(name: "picture") required File picture,
  });
}

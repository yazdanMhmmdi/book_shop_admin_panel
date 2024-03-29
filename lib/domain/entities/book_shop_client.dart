import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../core/constants/constants.dart';
import '../../data/models/auth_model.dart';
import '../../data/models/books_list_model.dart';
import '../../data/models/function_response_model.dart';
import '../../data/models/users_list_model.dart';

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

  @GET('/admin_delete_books.php')
  Future<HttpResponse<FunctionResponseModel>> deleteBooks({
    @Query("book_id") required String bookId,
  });

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
    @Part(name: "category_id") required String categoryId,
    @Part(name: "picture") required File picture,
    @Part(name: "sales_count") required String salesCount,
    @Part(name: "price") required String price,
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
    @Part(name: "sales_count") required String salesCount,
    @Part(name: "price") required String price,
  });

  @GET('/admin_search_books.php')
  Future<HttpResponse<BooksListModel>> searchBooks({
    @Query("category_id") required String categoryId,
    @Query("page") required String page,
    @Query("search") required String search,
  });
//*****************USERS**********************
  @GET('/admin_get_users.php')
  Future<HttpResponse<UsersListModel>> getUsers({
    @Query("page") required String page,
  });

  @GET('/admin_edit_users.php')
  Future<HttpResponse<FunctionResponseModel>> editUsers({
    @Query("user_id") required String userId,
    @Query("username") required String username,
    @Query("password") required String password,
    @Query("rule_type") required String ruleType,
  });

  @GET('/admin_delete_users.php')
  Future<HttpResponse<FunctionResponseModel>> deleteUsers({
    @Query("user_id") required String userId,
  });

  @GET('/admin_search_users.php')
  Future<HttpResponse<UsersListModel>> searchUsers({
    @Query("page") required String page,
    @Query("search") required String search,
  });

//********************** AUTH ***************************************

  @POST('/admin_login.php')
  @MultiPart()
  Future<HttpResponse<AuthModel>> login({
    @Part(name: 'username') required String username,
    @Part(name: 'password') required String password,
  });


//********************** APP UPDATES ***************************************

  @POST('/admin_add_apk.php')
  @MultiPart()
  Future<HttpResponse<FunctionResponseModel>> pushUpdate({
    @Part(name: "version") required String version,
    @Part(name: "apk") required File apk,
    @Part(name: "platform") required String platform,

  });

}

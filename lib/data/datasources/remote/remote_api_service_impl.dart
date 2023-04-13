import 'package:book_shop_admin_panel/data/models/book_model.dart';

import 'package:book_shop_admin_panel/core/params/request_params.dart';
import 'package:book_shop_admin_panel/data/models/function_response_model.dart';
import 'package:retrofit/dio.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/network/remote_api_service.dart';
import '../../../domain/entities/book_shop_client.dart';
import '../../models/books_list_model.dart';

class RemoteApiServiceImpl extends RemoteApiService {
  BookShopClient? bookShopClient;
  RemoteApiServiceImpl(this.bookShopClient);

  @override
  Future<BooksListModel> getBooks(BooksRequestParams params) async {
    try {
      final HttpResponse response = await bookShopClient!.fetchBooks(
          categoryId: params.categoryId.toString(),
          page: params.page.toString());

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException(
          message:
              "getBooksList->book_shop_api_service: ${error.toString()} parameters : ${params.page} ${params.categoryId}");
    }
  }

  @override
  Future<FunctionResponseModel> addBooks(AddBooksRequestParams params) async {
    try {
      final HttpResponse response = await bookShopClient!.addBooks(
        coverType: params.coverType!,
        description: params.description!,
        language: params.language!,
        pagesCount: params.pagesCount!,
        picture: params.pictureFile!,
        voteCount: params.voteCount!,
        writer: params.writer!,
        name: params.name!,
        categoryId: params.categoryId!,
      );

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException(
          message: "editBookApi->book_shop_api_service: ${error.toString()}");
    }
  }

  @override
  Future<FunctionResponseModel> deleteBooks(
      DeleteBooksRequestParams params) async {
    try {
      final HttpResponse response =
          await bookShopClient!.deleteBooks(bookId: params.bookId!);

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException(
          message: "deleteBookApi->book_shop_api_service: ${error.toString()}");
    }
  }

  @override
  Future<FunctionResponseModel> editBooks(EditBookRequestParams params) async {
    try {
      final HttpResponse response = await bookShopClient!.editBooks(
        bookId: params.bookId!,
        coverType: params.coverType!,
        description: params.description!,
        language: params.language!,
        pagesCount: params.pagesCount!,
        picture: params.pictureFile!,
        voteCount: params.voteCount!,
        writer: params.writer!,
        name: params.name!,
      );

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException(
          message: "editBookApi->book_shop_api_service: ${error.toString()}");
    }
  }
}

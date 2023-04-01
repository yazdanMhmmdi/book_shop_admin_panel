import 'package:book_shop_admin_panel/core/errors/failures.dart';
import 'package:book_shop_admin_panel/core/params/request_params.dart';
import 'package:book_shop_admin_panel/data/models/book_model.dart';
import 'package:book_shop_admin_panel/data/models/books_list_model.dart';
import 'package:book_shop_admin_panel/data/models/function_response_model.dart';
import 'package:dartz/dartz.dart';

abstract class BooksRepository {
  Future<Either<Failure, BooksListModel>> getBooksFromRepo(
      BooksRequestParams params);
  Future<Either<Failure, FunctionResponseModel>> editBooks(
      EditBookRequestParams params);
  Future<Either<Failure, BooksListModel>> deleteBooks(
      BooksRequestParams params);
  Future<Either<Failure, FunctionResponseModel>> addBooks(
      AddBooksRequestParams params);
}

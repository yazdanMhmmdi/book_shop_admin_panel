import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/params/request_params.dart';
import '../../data/models/books_list_model.dart';
import '../../data/models/function_response_model.dart';

abstract class BooksRepository {
  Future<Either<Failure, BooksListModel>> getBooksFromRepo(
      BooksRequestParams params);
  Future<Either<Failure, FunctionResponseModel>> editBooks(
      EditBookRequestParams params);
  Future<Either<Failure, FunctionResponseModel>> deleteBooks(
      DeleteBooksRequestParams params);
  Future<Either<Failure, FunctionResponseModel>> addBooks(
      AddBooksRequestParams params);

  Future<Either<Failure, BooksListModel>> searchBooks(
      SearchBooksRequestParams params);
}

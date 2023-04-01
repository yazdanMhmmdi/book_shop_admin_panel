import 'package:book_shop_admin_panel/core/network/remote_api_service.dart';
import 'package:book_shop_admin_panel/core/params/request_params.dart';
import 'package:book_shop_admin_panel/data/datasources/remote/remote_api_service_impl.dart';
import 'package:book_shop_admin_panel/data/models/book_model.dart';
import 'package:book_shop_admin_panel/core/errors/failures.dart';
import 'package:book_shop_admin_panel/data/models/function_response_model.dart';
import 'package:book_shop_admin_panel/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../models/books_list_model.dart';

class BooksRepositoryImpl implements BooksRepository {
  BooksRepositoryImpl(this.remoteApiService);
  RemoteApiService remoteApiService;

  @override
  Future<Either<Failure, BooksListModel>> getBooksFromRepo(
      BooksRequestParams params) async {
    try {
      final response = await remoteApiService.getBooks(params);

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }

  @override
  Future<Either<Failure, BooksListModel>> deleteBooks(
      BooksRequestParams params) {
    // TODO: implement deleteBooks
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, FunctionResponseModel>> editBooks(
      EditBookRequestParams params) async {
    try {
      final response = await remoteApiService.editBooks(params);

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }

  @override
  Future<Either<Failure, FunctionResponseModel>> addBooks(
      AddBooksRequestParams params) async {
    try {
      final response = await remoteApiService.addBooks(params);

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }
}

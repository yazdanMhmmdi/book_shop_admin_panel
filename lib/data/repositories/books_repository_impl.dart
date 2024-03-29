import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/network/book_remote_api_service.dart';
import '../../core/params/request_params.dart';
import '../../domain/repositories/books_repository.dart';
import '../models/books_list_model.dart';
import '../models/function_response_model.dart';

class BooksRepositoryImpl implements BooksRepository {
  BooksRepositoryImpl(this.remoteApiService);
  BookRemoteApiService remoteApiService;

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
  Future<Either<Failure, FunctionResponseModel>> deleteBooks(
      DeleteBooksRequestParams params) async {
    try {
      final response = await remoteApiService.deleteBooks(params);

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
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

  @override
  Future<Either<Failure, BooksListModel>> searchBooks(
      SearchBooksRequestParams params) async {
    try {
      final response = await remoteApiService.searchBooks(params);

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }
}

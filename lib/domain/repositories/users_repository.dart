import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/params/request_params.dart';
import '../../data/models/function_response_model.dart';
import '../../data/models/users_list_model.dart';

abstract class UsersRepository {
  Future<Either<Failure, UsersListModel>> getUsers(
      GetUsersRequestParams params);
  Future<Either<Failure, FunctionResponseModel>> editUsers(
      EditUsersRequestParams params);
  Future<Either<Failure, FunctionResponseModel>> deleteUsers(
      DeleteUsersRequestParams params);
  // Future<Either<Failure, FunctionResponseModel>> addBooks(
  //     AddBooksRequestParams params);

  Future<Either<Failure, UsersListModel>> searchUsers(
      SearchUsersRequestParams params);
}

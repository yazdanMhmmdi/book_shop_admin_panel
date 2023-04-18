import 'package:book_shop_admin_panel/core/errors/failures.dart';
import 'package:book_shop_admin_panel/core/params/request_params.dart';
import 'package:book_shop_admin_panel/data/models/users_list_model.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/function_response_model.dart';

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

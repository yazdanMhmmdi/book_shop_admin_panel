import '../../core/network/user_remote_api_service.dart';
import '../../core/params/request_params.dart';
import '../../core/utils/map_rule_types.dart';
import '../models/function_response_model.dart';
import '../models/users_list_model.dart';
import '../../domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';

class UsersRepositoryImpl implements UsersRepository {
  UsersRepositoryImpl(this.remoteApiService);
  UsersRemoteApiService remoteApiService;

  @override
  Future<Either<Failure, UsersListModel>> getUsers(
      GetUsersRequestParams params) async {
    try {
      final response = await remoteApiService.getUsers(params);

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }

  @override
  Future<Either<Failure, FunctionResponseModel>> editUsers(
      EditUsersRequestParams params) async {
    try {
      params.ruleType = MapRuleTypes.returnRule(params.ruleType);
      final response = await remoteApiService.editUsers(params);

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }

  @override
  Future<Either<Failure, FunctionResponseModel>> deleteUsers(
      DeleteUsersRequestParams params) async {
    try {
      final response = await remoteApiService.deleteUsers(params);

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }

  @override
  Future<Either<Failure, UsersListModel>> searchUsers(
      SearchUsersRequestParams params) async {
    try {
      final response = await remoteApiService.searchUsers(params);

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }
}

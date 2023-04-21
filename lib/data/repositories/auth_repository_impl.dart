import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/network/auth_remote_api_service.dart';
import '../../core/params/request_params.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/auth_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.remoteApiService);
  AuthRemoteApiService remoteApiService;

  @override
  Future<Either<Failure, AuthModel>> login(
      AuthLoginRequestParams params) async {
    try {
      final response = await remoteApiService.login(params);
      // if (response.errorMessage == "")
      switch (response.errorMessage) {
        case "wrong username or password.":
          return Left(WrongAuthFailure());
        default:
          return Right(response);
      }
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }
}

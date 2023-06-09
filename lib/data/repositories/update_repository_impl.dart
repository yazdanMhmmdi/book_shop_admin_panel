import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/network/update_remote_api_service.dart';
import '../../core/params/request_params.dart';
import '../../domain/repositories/update_repository.dart';
import '../models/function_response_model.dart';

class UpdateRepositoryImpl implements UpdateRepository {
  UpdateRepositoryImpl(this.remoteApiService);
  UpdateRemoteApiService remoteApiService;

  @override
  Future<Either<Failure, FunctionResponseModel>> pushUpdate(
      PushUpdateRequestParams params) async {
    try {
      final response = await remoteApiService.pushUpdate(params);

      return Right(response);
    } on ServerException catch (error) {
      return Left(ServerFailure(message: error.message.toString()));
    }
  }
}

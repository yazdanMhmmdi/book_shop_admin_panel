import 'package:book_shop_admin_panel/core/network/update_remote_api_service.dart';
import 'package:book_shop_admin_panel/data/models/function_response_model.dart';
import 'package:book_shop_admin_panel/domain/repositories/update_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../core/network/auth_remote_api_service.dart';
import '../../core/params/request_params.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/auth_model.dart';

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

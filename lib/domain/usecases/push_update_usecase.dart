import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/params/request_params.dart';
import '../../core/usecase/usecase.dart';
import '../../data/models/function_response_model.dart';
import '../repositories/update_repository.dart';

class PushUpdateUsecase
    implements UseCase<FunctionResponseModel, PushUpdateRequestParams> {
  PushUpdateUsecase(this._repository);
  UpdateRepository? _repository;

  @override
  Future<Either<Failure, FunctionResponseModel>> call(
      PushUpdateRequestParams params) async {
    return await _repository!.pushUpdate(params);
  }
}

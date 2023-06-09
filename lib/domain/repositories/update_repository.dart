import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/params/request_params.dart';
import '../../data/models/function_response_model.dart';

abstract class UpdateRepository {
  Future<Either<Failure, FunctionResponseModel>> pushUpdate(
      PushUpdateRequestParams params);
}

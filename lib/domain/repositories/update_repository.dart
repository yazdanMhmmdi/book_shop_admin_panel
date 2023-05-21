import 'package:book_shop_admin_panel/data/models/function_response_model.dart';

import '../../core/errors/failures.dart';
import '../../core/params/request_params.dart';
import '../../data/models/auth_model.dart';
import 'package:dartz/dartz.dart';

abstract class UpdateRepository {
  Future<Either<Failure, FunctionResponseModel>> pushUpdate(
      PushUpdateRequestParams params);
}

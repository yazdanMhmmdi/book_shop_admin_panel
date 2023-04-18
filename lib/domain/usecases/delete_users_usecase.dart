import 'package:book_shop_admin_panel/core/params/request_params.dart';
import 'package:book_shop_admin_panel/data/models/function_response_model.dart';
import 'package:book_shop_admin_panel/domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/usecase/usecase.dart';

class DeleteUsersUsecase
    implements UseCase<FunctionResponseModel, DeleteUsersRequestParams> {
  DeleteUsersUsecase(this._repository);
  UsersRepository? _repository;

  @override
  Future<Either<Failure, FunctionResponseModel>> call(
      DeleteUsersRequestParams params) async {
    return await _repository!.deleteUsers(params);
  }
}

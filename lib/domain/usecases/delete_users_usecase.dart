import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/params/request_params.dart';
import '../../core/usecase/usecase.dart';
import '../../data/models/function_response_model.dart';
import '../repositories/users_repository.dart';

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

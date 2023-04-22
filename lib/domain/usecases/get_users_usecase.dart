import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/params/request_params.dart';
import '../../core/usecase/usecase.dart';
import '../../data/models/users_list_model.dart';
import '../repositories/users_repository.dart';

class GetUsersUsecase
    implements UseCase<UsersListModel, GetUsersRequestParams> {
  GetUsersUsecase(this._repository);
  UsersRepository? _repository;

  @override
  Future<Either<Failure, UsersListModel>> call(
      GetUsersRequestParams params) async {
    return await _repository!.getUsers(params);
  }
}

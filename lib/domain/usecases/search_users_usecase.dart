import 'package:book_shop_admin_panel/core/params/request_params.dart';
import 'package:book_shop_admin_panel/data/models/users_list_model.dart';
import 'package:book_shop_admin_panel/domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/usecase/usecase.dart';

class SearchUsersUsecase
    implements UseCase<UsersListModel, SearchUsersRequestParams> {
  SearchUsersUsecase(this._repository);
  UsersRepository? _repository;

  @override
  Future<Either<Failure, UsersListModel>> call(
      SearchUsersRequestParams params) async {
    return await _repository!.searchUsers(params);
  }
}

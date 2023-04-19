import 'package:book_shop_admin_panel/core/params/request_params.dart';
import 'package:book_shop_admin_panel/data/models/users_list_model.dart';
import 'package:book_shop_admin_panel/domain/repositories/books_repository.dart';
import 'package:book_shop_admin_panel/domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/usecase/usecase.dart';
import '../../data/models/books_list_model.dart';

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
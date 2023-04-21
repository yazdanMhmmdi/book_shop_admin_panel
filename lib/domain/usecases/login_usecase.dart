import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/params/request_params.dart';
import '../../core/usecase/usecase.dart';
import '../../data/models/auth_model.dart';
import '../repositories/auth_repository.dart';

class LoginUsecase implements UseCase<AuthModel, AuthLoginRequestParams> {
  LoginUsecase(this._repository);
  AuthRepository? _repository;

  @override
  Future<Either<Failure, AuthModel>> call(AuthLoginRequestParams params) async {
    return await _repository!.login(params);
  }
}

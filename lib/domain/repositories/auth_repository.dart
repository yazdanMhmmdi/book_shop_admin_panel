import '../../core/errors/failures.dart';
import '../../core/params/request_params.dart';
import '../../data/models/auth_model.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthModel>> login(AuthLoginRequestParams params);
}

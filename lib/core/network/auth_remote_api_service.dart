import '../../data/models/auth_model.dart';
import '../params/request_params.dart';

abstract class AuthRemoteApiService {
  Future<AuthModel> login(AuthLoginRequestParams params);
}

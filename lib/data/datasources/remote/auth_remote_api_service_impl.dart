import 'package:retrofit/dio.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/network/auth_remote_api_service.dart';
import '../../../core/params/request_params.dart';
import '../../../domain/entities/book_shop_client.dart';
import '../../models/auth_model.dart';

class AuthRemoteApiServiceImpl extends AuthRemoteApiService {
  BookShopClient? bookShopClient;
  AuthRemoteApiServiceImpl(this.bookShopClient);

  @override
  Future<AuthModel> login(AuthLoginRequestParams params) async {
    try {
      final HttpResponse response = await bookShopClient!
          .login(username: params.username!, password: params.password!);

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException(
          message: "loginAuth->book_shop_api_service: ${error.toString()}");
    }
  }
}

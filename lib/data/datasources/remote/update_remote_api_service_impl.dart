import 'package:retrofit/dio.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/network/update_remote_api_service.dart';
import '../../../core/params/request_params.dart';
import '../../../domain/entities/book_shop_client.dart';
import '../../models/function_response_model.dart';

class UpdateRemoteApiServiceImpl extends UpdateRemoteApiService {
  BookShopClient? bookShopClient;
  UpdateRemoteApiServiceImpl(this.bookShopClient);

  @override
  Future<FunctionResponseModel> pushUpdate(
      PushUpdateRequestParams params) async {
    try {
      final HttpResponse response = await bookShopClient!.pushUpdate(
          version: params.version!,
          apk: params.apk!,
          platform: params.platform!);

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException(
          message: "Update->book_shop_api_service: ${error.toString()}");
    }
  }
}

import 'package:retrofit/dio.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/network/user_remote_api_service.dart';
import '../../../core/params/request_params.dart';
import '../../../domain/entities/book_shop_client.dart';
import '../../models/function_response_model.dart';
import '../../models/users_list_model.dart';

class UserRemoteApiServiceImpl extends UsersRemoteApiService {
  BookShopClient? bookShopClient;
  UserRemoteApiServiceImpl(this.bookShopClient);

  @override
  Future<UsersListModel> getUsers(GetUsersRequestParams params) async {
    try {
      final HttpResponse response =
          await bookShopClient!.getUsers(page: params.page.toString());

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException(
          message:
              "getUsersList->book_shop_api_service: ${error.toString()} parameters : ${params.page}");
    }
  }

  @override
  Future<FunctionResponseModel> editUsers(EditUsersRequestParams params) async {
    try {
      final HttpResponse response = await bookShopClient!.editUsers(
        userId: params.userId!,
        password: params.password!,
        username: params.username!,
        ruleType: params.ruleType!,
      );

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException(
          message:
              "editUsers->book_shop_api_service: ${error.toString()} parameters : ${params.userId}");
    }
  }

  @override
  Future<FunctionResponseModel> deleteUsers(
      DeleteUsersRequestParams params) async {
    try {
      final HttpResponse response = await bookShopClient!.deleteUsers(
        userId: params.userId!,
      );

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException(
          message:
              "deleteUsers->book_shop_api_service: ${error.toString()} parameters : ${params.userId}");
    }
  }

  @override
  Future<UsersListModel> searchUsers(SearchUsersRequestParams params) async {
    try {
      final HttpResponse response = await bookShopClient!.searchUsers(
        search: params.search!,
        page: params.page!,
      );

      if (response.response.statusCode == 200) {
        return response.data;
      } else {
        throw ServerException();
      }
    } catch (error) {
      throw ServerException(
          message:
              "searchUsers->book_shop_api_service: ${error.toString()} parameters : ${params.search}  page: ${params.page}");
    }
  }
}

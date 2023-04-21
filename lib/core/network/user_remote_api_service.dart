import '../../data/models/users_list_model.dart';
import '../../data/models/function_response_model.dart';
import '../params/request_params.dart';

abstract class UsersRemoteApiService {
  Future<UsersListModel> getUsers(GetUsersRequestParams params);
  Future<FunctionResponseModel> editUsers(EditUsersRequestParams params);
  // Future<FunctionResponseModel> addBooks(AddBooksRequestParams params);
  Future<FunctionResponseModel> deleteUsers(DeleteUsersRequestParams params);
  Future<UsersListModel> searchUsers(SearchUsersRequestParams params);
}

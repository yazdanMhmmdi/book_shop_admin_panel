import '../../data/models/books_list_model.dart';
import '../../data/models/function_response_model.dart';
import '../params/request_params.dart';

abstract class UpdateRemoteApiService {
  Future<FunctionResponseModel> pushUpdate(PushUpdateRequestParams params);
}

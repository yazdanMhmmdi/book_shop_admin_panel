import 'package:book_shop_admin_panel/data/models/function_response_model.dart';

import '../../data/models/book_model.dart';
import '../../data/models/books_list_model.dart';
import '../params/request_params.dart';

abstract class RemoteApiService {
  // Future<HomeModel> getHome();
  // Future<TitlePostsModel> getTitlePost(TitlesPostRequestParams params);
  // Future<AuthModel> login(AuthRequestParams params);
  // Future<AuthModel> signUp(AuthRequestParams params);

  // Future<BasketModel> getBasket(BasketRequestParams params);
  // Future<FunctionResponseModel> addBasket(BasketRequestParams params);
  // Future<FunctionResponseModel> deleteBasket(BasketRequestParams params);

  // Future<UserModel> getAccount(AccountRequestParams params);
  // Future<FunctionResponseModel> editAccount(AccountRequestParams params);
  Future<BooksListModel> getBooks(BooksRequestParams params);
  Future<FunctionResponseModel> editBooks(EditBookRequestParams params);
  Future<FunctionResponseModel> addBooks(AddBooksRequestParams params);
  Future<FunctionResponseModel> deleteBooks(DeleteBooksRequestParams params);
}

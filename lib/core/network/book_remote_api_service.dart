import '../../data/models/function_response_model.dart';

import '../../data/models/book_model.dart';
import '../../data/models/books_list_model.dart';
import '../params/request_params.dart';

abstract class BookRemoteApiService {
  Future<BooksListModel> getBooks(BooksRequestParams params);
  Future<FunctionResponseModel> editBooks(EditBookRequestParams params);
  Future<FunctionResponseModel> addBooks(AddBooksRequestParams params);
  Future<FunctionResponseModel> deleteBooks(DeleteBooksRequestParams params);
  Future<BooksListModel> searchBooks(SearchBooksRequestParams params);
}



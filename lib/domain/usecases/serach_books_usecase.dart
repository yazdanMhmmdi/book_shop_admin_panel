import '../../core/params/request_params.dart';
import '../../data/models/book_model.dart';
import '../repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/usecase/usecase.dart';
import '../../data/models/books_list_model.dart';

class SearchBooksUsecase
    implements UseCase<BooksListModel, SearchBooksRequestParams> {
  SearchBooksUsecase(this._repository);
  BooksRepository? _repository;

  @override
  Future<Either<Failure, BooksListModel>> call(
      SearchBooksRequestParams params) async {
    return await _repository!.searchBooks(params);
  }
}

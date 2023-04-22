import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/params/request_params.dart';
import '../../core/usecase/usecase.dart';
import '../../data/models/books_list_model.dart';
import '../repositories/books_repository.dart';

class GetBooksUsecase implements UseCase<BooksListModel, BooksRequestParams> {
  GetBooksUsecase(this._repository);
  BooksRepository? _repository;

  @override
  Future<Either<Failure, BooksListModel>> call(
      BooksRequestParams params) async {
    return await _repository!.getBooksFromRepo(params);
  }
}

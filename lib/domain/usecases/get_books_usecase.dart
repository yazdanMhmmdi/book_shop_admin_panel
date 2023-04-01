import 'package:book_shop_admin_panel/core/params/request_params.dart';
import 'package:book_shop_admin_panel/data/models/book_model.dart';
import 'package:book_shop_admin_panel/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/usecase/usecase.dart';
import '../../data/models/books_list_model.dart';

class GetBooksUsecase implements UseCase<BooksListModel, BooksRequestParams> {
  GetBooksUsecase(this._repository);
  BooksRepository? _repository;

  @override
  Future<Either<Failure, BooksListModel>> call(
      BooksRequestParams params) async {
    return await _repository!.getBooksFromRepo(params);
  }
}

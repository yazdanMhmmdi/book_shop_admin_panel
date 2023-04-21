import '../../core/params/request_params.dart';
import '../../data/models/book_model.dart';
import '../../data/models/function_response_model.dart';
import '../repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../core/usecase/usecase.dart';
import '../../data/models/books_list_model.dart';

class EditBookUsecase
    implements UseCase<FunctionResponseModel, EditBookRequestParams> {
  EditBookUsecase(this._repository);
  BooksRepository? _repository;

  @override
  Future<Either<Failure, FunctionResponseModel>> call(
      EditBookRequestParams params) async {
    return await _repository!.editBooks(params);
  }
}

import 'dart:io';

class BooksRequestParams {
  int? categoryId = 1, page = 1;

  BooksRequestParams({this.categoryId, this.page});
}

class EditBookRequestParams {
  String? name = "",
      writer = "",
      description = "",
      language = "",
      coverType = "",
      pagesCount = "",
      voteCount = "",
      categoryId = "",
      bookId = "",
      salesCount = "",
      price = "";
  File? pictureFile;
  EditBookRequestParams({
    this.pagesCount,
    this.voteCount,
    this.language,
    this.coverType,
    this.description,
    this.name,
    this.writer,
    this.bookId,
    this.categoryId,
    this.price,
    this.salesCount,
    required this.pictureFile,
  });
}

class AddBooksRequestParams {
  String? name = "",
      writer = "",
      description = "",
      language = "",
      coverType = "",
      pagesCount = "",
      voteCount = "",
      categoryId = "",
      salesCount = "",
      price = "";

  File? pictureFile;

  AddBooksRequestParams({
    this.pagesCount,
    this.voteCount,
    this.language,
    this.coverType,
    this.description,
    this.name,
    this.writer,
    this.categoryId,
    this.price,
    this.salesCount,
    required this.pictureFile,
  });
}

class DeleteBooksRequestParams {
  String? bookId = '';

  DeleteBooksRequestParams({
    this.bookId,
  });
}

class SearchBooksRequestParams {
  String? search = '';
  String? categoryId = '';
  String? page = '';

  SearchBooksRequestParams({this.search, this.page, this.categoryId});
}

//**********USERS***************
class GetUsersRequestParams {
  String? page = '';

  GetUsersRequestParams({
    this.page,
  });
}

class EditUsersRequestParams {
  String? userId = '';
  String? username = '';
  String? password = '';
  String? ruleType = "user";

  EditUsersRequestParams({
    this.password,
    this.userId,
    this.username,
    this.ruleType,
  });
}

class DeleteUsersRequestParams {
  String? userId = '';

  DeleteUsersRequestParams({
    this.userId,
  });
}

class SearchUsersRequestParams {
  String? search = '';
  String? page = '';

  SearchUsersRequestParams({
    this.search,
    this.page,
  });
}

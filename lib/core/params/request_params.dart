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
      bookId = "";
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
      categoryId = "";
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
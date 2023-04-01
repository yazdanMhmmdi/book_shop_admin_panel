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
  String? bookId = "", userid = "";

  DeleteBooksRequestParams({
    this.bookId,
    this.userid,
  });
}

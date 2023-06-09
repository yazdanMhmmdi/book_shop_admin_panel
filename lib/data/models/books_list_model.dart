import 'package:json_annotation/json_annotation.dart';

import 'book_model.dart';
import 'data_model.dart';

part 'books_list_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class BooksListModel {
  String? error;
  String? errorMessage;
  List<BookModel>? books;
  DataModel? data;
  BooksListModel({
    this.books,
    this.data,
    this.error,
    this.errorMessage,
  });

  factory BooksListModel.fromJson(Map<String, dynamic> json) =>
      _$BooksListModelFromJson(json);

  Map<String, dynamic> toJson() => _$BooksListModelToJson(this);
}

import 'package:book_shop_admin_panel/data/models/book_model.dart';
import 'package:book_shop_admin_panel/data/models/data_model.dart';
import 'package:book_shop_admin_panel/domain/entities/data.dart';
import 'package:json_annotation/json_annotation.dart';
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

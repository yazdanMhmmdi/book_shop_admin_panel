// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooksListModel _$BooksListModelFromJson(Map<String, dynamic> json) =>
    BooksListModel(
      books: (json['books'] as List<dynamic>?)
          ?.map((e) => BookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      data: json['data'] == null
          ? null
          : DataModel.fromJson(json['data'] as Map<String, dynamic>),
      error: json['error'] as String?,
      errorMessage: json['error_message'] as String?,
    );

Map<String, dynamic> _$BooksListModelToJson(BooksListModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'error_message': instance.errorMessage,
      'books': instance.books,
      'data': instance.data,
    };

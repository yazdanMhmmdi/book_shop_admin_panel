// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map<String, dynamic> json) => BookModel(
      blurhash: json['blurhash'] as String? ?? '',
      categoryId: json['category_id'] as String? ?? '',
      cover: json['cover'] as String? ?? '',
      coverType: json['cover_type'] as String? ?? '',
      description: json['description'] as String? ?? '',
      id: json['id'] as String? ?? '',
      isBanner: json['is_banner'] as String? ?? '',
      language: json['language'] as String? ?? '',
      name: json['name'] as String? ?? '',
      pagesCount: json['pages_count'] as String? ?? '',
      picture: json['picture'] as String? ?? '',
      pictureThumb: json['picture_thumb'] as String? ?? '',
      posterText: json['poster_text'] as String? ?? '',
      price: json['price'] == null ? 0.0 : Book.dataFromJson(json['price']),
      salesCount: json['sales_count'] as String? ?? '',
      voteCount: json['vote_count'] == null
          ? 0.0
          : Book.dataFromJson(json['vote_count']),
      writer: json['writer'] as String? ?? '',
    );

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
      'id': instance.id,
      'cover': instance.cover,
      'pages_count': instance.pagesCount,
      'vote_count': instance.voteCount,
      'writer': instance.writer,
      'description': instance.description,
      'name': instance.name,
      'price': instance.price,
      'language': instance.language,
      'cover_type': instance.coverType,
      'picture_thumb': instance.pictureThumb,
      'picture': instance.picture,
      'sales_count': instance.salesCount,
      'is_banner': instance.isBanner,
      'category_id': instance.categoryId,
      'poster_text': instance.posterText,
      'blurhash': instance.blurhash,
    };

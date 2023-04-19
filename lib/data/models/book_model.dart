import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/book.dart';
part 'book_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class BookModel extends Book {
  BookModel(
      {String? blurhash,
      String? categoryId,
      String? cover,
      String? coverType,
      String? description,
      String? id,
      String? isBanner,
      String? language,
      String? name,
      String? pagesCount,
      String? picture,
      String? pictureThumb,
      String? posterText,
      String? price,
      String? salesCount,
      double? voteCount,
      String? writer})
      : super(
            blurhash: blurhash!,
            categoryId: categoryId!,
            cover: cover!,
            coverType: coverType!,
            description: description!,
            id: id!,
            isBanner: isBanner!,
            language: language!,
            name: name!,
            pagesCount: pagesCount!,
            picture: picture!,
            pictureThumb: pictureThumb!,
            posterText: posterText!,
            price: price!,
            salesCount: salesCount!,
            voteCount: voteCount!,
            writer: writer!);

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookModelToJson(this);
}

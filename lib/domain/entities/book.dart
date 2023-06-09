import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../core/utils/image_address_provider.dart';

class Book extends Equatable {
  @JsonKey(defaultValue: 1, fromJson: toInt)
  late final int? rowid;
  @JsonKey(defaultValue: '')
  late final String? id;
  @JsonKey(defaultValue: '')
  late final String? cover;
  @JsonKey(defaultValue: '')
  late final String? pagesCount;
  @JsonKey(name: 'vote_count', fromJson: dataFromJson, defaultValue: 0.0)
  late final double? voteCount;
  @JsonKey(defaultValue: '')
  late final String? writer;
  @JsonKey(defaultValue: '')
  late final String? description;
  @JsonKey(defaultValue: '')
  late final String? name;
  @JsonKey(name: 'price', defaultValue: '0')
  late final String? price;
  @JsonKey(defaultValue: '')
  late final String? language;
  @JsonKey(defaultValue: '')
  late final String? coverType;
  @JsonKey(defaultValue: '', fromJson: convertToURL)
  late final String? pictureThumb;
  @JsonKey(defaultValue: '', fromJson: convertToURL)
  late final String? picture;
  @JsonKey(defaultValue: '')
  late final String? salesCount;
  @JsonKey(defaultValue: '')
  late final String? isBanner;
  @JsonKey(defaultValue: '')
  late final String? categoryId;
  @JsonKey(defaultValue: '')
  late final String? posterText;
  @JsonKey(defaultValue: '')
  late final String? blurhash;
  Book({
    required this.blurhash,
    required this.categoryId,
    required this.cover,
    required this.coverType,
    required this.description,
    required this.id,
    required this.isBanner,
    required this.language,
    required this.name,
    required this.pagesCount,
    required this.picture,
    required this.pictureThumb,
    required this.posterText,
    required this.price,
    required this.salesCount,
    required this.voteCount,
    required this.writer,
    required this.rowid,
  });
  @override
  List<Object?> get props => [
        rowid,
        blurhash,
        categoryId,
        cover,
        coverType,
        description,
        id,
        isBanner,
        language,
        name,
        pagesCount,
        picture,
        pictureThumb,
        posterText,
        price,
        salesCount,
        voteCount,
        writer
      ];

  static double? dataFromJson(dynamic json) {
    return double.parse(json.toString());
  }

  static String? convertToURL(String imgAddress) {
    return ImageAddressProvider.getAddress(imgAddress);
  }

  static int? toInt(String str) => int.parse(str);
}

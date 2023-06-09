// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class Data extends Equatable {
  @JsonKey(name: 'total_pages', fromJson: dataFromJson, defaultValue: 0.0)
  double? totalPages;
  @JsonKey(name: 'current_page', fromJson: dataFromJson, defaultValue: 0.0)
  double? currentPage;
  @JsonKey(name: 'offset_page', fromJson: dataFromJson, defaultValue: 0.0)
  double? offsetPage;

  Data({this.currentPage, this.offsetPage, this.totalPages});
  @override
  List<Object?> get props => [
        totalPages,
        currentPage,
        offsetPage,
      ];

  static double? dataFromJson(dynamic json) {
    return double.parse(json.toString());
  }
}

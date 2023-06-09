// ignore_for_file: must_be_immutable

import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/data.dart';

part 'data_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class DataModel extends Data {
  DataModel({
    double? totalPages,
    double? currentPage,
    double? offsetPage,
  }) : super(
            currentPage: currentPage,
            offsetPage: offsetPage,
            totalPages: totalPages);
  factory DataModel.fromJson(Map<String, dynamic> json) =>
      _$DataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}

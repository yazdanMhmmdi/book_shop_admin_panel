// ignore_for_file: must_be_immutable

import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/Auth.dart';

part 'auth_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AuthModel extends Auth {
  @JsonKey(defaultValue: '')
  String? error;
  @JsonKey(defaultValue: '')
  String? errorMessage;
  @JsonKey(defaultValue: '')
  String? userId;
  AuthModel({
    this.error,
    this.errorMessage,
    this.userId,
  }) : super(
          error: error!,
          errorMessage: errorMessage!,
          userId: userId!,
        );

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class User extends Equatable {
  @JsonKey(defaultValue: '')
  late final String? id;
  @JsonKey(defaultValue: '')
  late final String? username;
  @JsonKey(defaultValue: '')
  late final String? password;
  @JsonKey(defaultValue: '')
  late final String? ruleType;
  @JsonKey(defaultValue: '')
  late final String? picture;
  @JsonKey(defaultValue: '')
  late final String? thumbPicture;
  @JsonKey(defaultValue: '')
  late final String? createdAt;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.ruleType,
    required this.picture,
    required this.thumbPicture,
    required this.createdAt,
  });
  @override
  List<Object?> get props => [
        id,
        username,
        password,
        ruleType,
        picture,
        thumbPicture,
        createdAt,
      ];
}

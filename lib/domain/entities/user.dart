import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../core/utils/map_rule_types.dart';

class User extends Equatable {
  @JsonKey(defaultValue: 1, fromJson: toInt)
  late final int? rowid;
  @JsonKey(defaultValue: '')
  late final String? id;
  @JsonKey(defaultValue: '')
  late final String? username;
  @JsonKey(defaultValue: '')
  late final String? password;
  @JsonKey(
      name: 'rule_type',
      fromJson: MapRuleTypes.returnTitle,
      defaultValue: 'user')
  late final String? ruleType;
  @JsonKey(defaultValue: '')
  late final String? picture;
  @JsonKey(defaultValue: '')
  late final String? thumbPicture;
  @JsonKey(defaultValue: '')
  late final String? createdAt;

  User({
    required this.rowid,
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
        rowid,
        id,
        username,
        password,
        ruleType,
        picture,
        thumbPicture,
        createdAt,
      ];

  static int? toInt(String str) => int.parse(str);
}

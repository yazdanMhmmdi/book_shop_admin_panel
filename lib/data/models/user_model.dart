import 'package:json_annotation/json_annotation.dart';

import '../../core/utils/map_rule_types.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class UserModel extends User {
  UserModel({
    int? rowid,
    String? id,
    String? username,
    String? password,
    String? ruleType,
    String? picture,
    String? thumbPicture,
    String? createdAt,
  }) : super(
          rowid: rowid,
          createdAt: createdAt,
          id: id,
          password: password,
          picture: picture,
          ruleType: ruleType,
          username: username,
          thumbPicture: thumbPicture,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

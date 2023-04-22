import 'package:json_annotation/json_annotation.dart';

import 'data_model.dart';
import 'user_model.dart';

part 'users_list_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class UsersListModel {
  String? error;
  String? errorMessage;
  List<UserModel>? users;
  DataModel? data;
  UsersListModel({
    this.users,
    this.data,
    this.error,
    this.errorMessage,
  });

  factory UsersListModel.fromJson(Map<String, dynamic> json) =>
      _$UsersListModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersListModelToJson(this);
}

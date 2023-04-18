// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UsersListModel _$UsersListModelFromJson(Map<String, dynamic> json) =>
    UsersListModel(
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      data: json['data'] == null
          ? null
          : DataModel.fromJson(json['data'] as Map<String, dynamic>),
      error: json['error'] as String?,
      errorMessage: json['error_message'] as String?,
    );

Map<String, dynamic> _$UsersListModelToJson(UsersListModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'error_message': instance.errorMessage,
      'users': instance.users,
      'data': instance.data,
    };

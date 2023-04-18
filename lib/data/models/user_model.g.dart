// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String? ?? '',
      username: json['username'] as String? ?? '',
      password: json['password'] as String? ?? '',
      ruleType: json['rule_type'] as String? ?? '',
      picture: json['picture'] as String? ?? '',
      thumbPicture: json['thumb_picture'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'rule_type': instance.ruleType,
      'picture': instance.picture,
      'thumb_picture': instance.thumbPicture,
      'created_at': instance.createdAt,
    };

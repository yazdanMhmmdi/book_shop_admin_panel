// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataModel _$DataModelFromJson(Map<String, dynamic> json) => DataModel(
      totalPages: json['total_pages'] == null
          ? 0.0
          : Data.dataFromJson(json['total_pages']),
      currentPage: json['current_page'] == null
          ? 0.0
          : Data.dataFromJson(json['current_page']),
      offsetPage: json['offset_page'] == null
          ? 0.0
          : Data.dataFromJson(json['offset_page']),
    );

Map<String, dynamic> _$DataModelToJson(DataModel instance) => <String, dynamic>{
      'total_pages': instance.totalPages,
      'current_page': instance.currentPage,
      'offset_page': instance.offsetPage,
    };

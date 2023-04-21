import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/function_response.dart';

part 'function_response_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FunctionResponseModel extends FunctionResponse {
  FunctionResponseModel({
    required String error,
    required String errorMessage,
    required String status,
  }) : super(
          error: error,
          errorMessage: errorMessage,
          status: status,
        );

  factory FunctionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FunctionResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FunctionResponseModelToJson(this);
}

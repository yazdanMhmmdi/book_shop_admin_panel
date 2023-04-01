import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class FunctionResponse extends Equatable {
  String error;
  String errorMessage = "";
  String status;
  // @JsonKey(defaultValue: '')
  // String? userId;
  // @JsonKey(defaultValue: '')
  // String? bookId;
  FunctionResponse({
    required this.error,
    required this.errorMessage,
    required this.status,
  });
  @override
  List<Object?> get props => [
        error,
        errorMessage,
        status,
      ];
}

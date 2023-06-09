// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

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

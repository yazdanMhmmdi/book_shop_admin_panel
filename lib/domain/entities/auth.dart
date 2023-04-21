import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class Auth extends Equatable {
  @JsonKey(defaultValue: '')
  String? error;
  @JsonKey(defaultValue: '')
  String? errorMessage;
  @JsonKey(defaultValue: '')
  String? userId;
  Auth({required this.error, required this.userId, required this.errorMessage});
  @override
  List<Object?> get props => [
        error,
        errorMessage,
        userId,
      ];
}

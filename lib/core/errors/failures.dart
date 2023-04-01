import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}
//  Some General Failures

class ServerFailure extends Failure {
  String? message;
  ServerFailure({this.message = ""});
  @override
  List<Object?> get props => [this.message];
}

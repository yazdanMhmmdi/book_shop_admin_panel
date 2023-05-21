part of 'update_bloc.dart';

abstract class UpdateState extends Equatable {
  const UpdateState();

  @override
  List<Object> get props => [];
}

class UpdateInitial extends UpdateState {}

class UpdateFailure extends UpdateState {}

class UpdateSuccess extends UpdateState {}

class UpdateLoading extends UpdateState {}

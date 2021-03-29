part of 'tabslider_bloc.dart';

abstract class TabsliderState extends Equatable {
  const TabsliderState();

  @override
  List<Object> get props => [];
}

class TabsliderInitial extends TabsliderState {}

class TabsliderSuccess extends TabsliderState {
  var tab;
  TabsliderSuccess(this.tab);
  @override
  List<Object> get props => [tab];
}

part of 'tabslider_bloc.dart';

abstract class TabsliderState extends Equatable {
  const TabsliderState();

  @override
  List<Object> get props => [];
}

class TabsliderInitial extends TabsliderState {}

class TabsliderSuccess extends TabsliderState {
  var tab;
  var orginalTab;
  TabsliderSuccess(this.tab, this.orginalTab);
  @override
  List<Object> get props => [tab, orginalTab];
}

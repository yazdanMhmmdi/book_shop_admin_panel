part of 'tabslider_bloc.dart';

abstract class TabsliderEvent extends Equatable {
  const TabsliderEvent();

  @override
  List<Object> get props => [];
}

class MoveForwardEvent extends TabsliderEvent {
  int tab;
  TabsliderBloc tabSliderBloc;
  CategoryBloc categoryBloc;
  MoveForwardEvent(
      {@required this.tab,
      @required this.tabSliderBloc,
      @required this.categoryBloc});

  @override
  List<Object> get props => [this.tab, this.tabSliderBloc, this.categoryBloc];
}

part of 'tabslider_bloc.dart';

abstract class TabsliderEvent extends Equatable {
  const TabsliderEvent();

  @override
  List<Object> get props => [];
}

class MoveForwardEvent extends TabsliderEvent {
  int tab;
  TabsliderBloc tabSliderBloc;
  BookBloc bookBloc;
  UsersBloc usersBloc;
  var orginalTab;

  MoveForwardEvent(
      {@required this.tab,
      @required this.tabSliderBloc,
      @required this.bookBloc,
      this.usersBloc,
       this.orginalTab});

  @override
  List<Object> get props => [
        this.tab,
        this.tabSliderBloc,
        this.bookBloc,
        this.usersBloc,
        this.orginalTab
      ];
}

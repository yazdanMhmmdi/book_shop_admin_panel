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
  ChatBloc chatBloc;
  var orginalTab;
  Map<String, String> args;

  MoveForwardEvent(
      {@required this.tab,
      @required this.tabSliderBloc,
      this.bookBloc,
      this.usersBloc,
      this.chatBloc,
      this.orginalTab,
      this.args});

  @override
  List<Object> get props => [
        this.tab,
        this.tabSliderBloc,
        this.bookBloc,
        this.usersBloc,
        this.orginalTab,
        this.args
      ];
}

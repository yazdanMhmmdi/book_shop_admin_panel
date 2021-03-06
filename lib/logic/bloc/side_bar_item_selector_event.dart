part of 'side_bar_item_selector_bloc.dart';

abstract class SideBarItemSelectorEvent extends Equatable {
  const SideBarItemSelectorEvent();

  @override
  List<Object> get props => [];
}

class SelectItemEvent extends SideBarItemSelectorEvent {
  var currentTab;
  var orginalTab;
  BuildContext context;
  Function onTap;
  BookBloc bookBloc;
  UsersBloc usersBloc;
  SelectItemEvent(
      {@required this.currentTab,
      @required this.context,
      @required this.onTap,
      @required this.orginalTab,
      @required this.bookBloc,
      @required this.usersBloc});

  @override
  // TODO: implement props
  List<Object> get props => [currentTab, bookBloc,usersBloc];
}

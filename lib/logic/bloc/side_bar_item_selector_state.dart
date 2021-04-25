part of 'side_bar_item_selector_bloc.dart';

abstract class SideBarItemSelectorState extends Equatable {
  const SideBarItemSelectorState();

  @override
  List<Object> get props => [];
}

class SideBarItemSelectorInitial extends SideBarItemSelectorState {}

class SideBarItemSelectorSuccess extends SideBarItemSelectorState {
  bool add;
  Function editFunction;
  SideBarItemSelectorSuccess({@required this.add, @required this.editFunction});

  @override
  List<Object> get props => [add];
}

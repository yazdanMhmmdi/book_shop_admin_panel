part of 'side_bar_item_selector_bloc.dart';

abstract class SideBarItemSelectorEvent extends Equatable {
  const SideBarItemSelectorEvent();

  @override
  List<Object> get props => [];
}


class SelectItemEvent extends SideBarItemSelectorEvent {
  var currentTab;
  BuildContext context;
  Function onTap;
  SelectItemEvent({@required this.currentTab,@required this.context, @required this.onTap});

  @override
  // TODO: implement props
  List<Object> get props => [currentTab];
}

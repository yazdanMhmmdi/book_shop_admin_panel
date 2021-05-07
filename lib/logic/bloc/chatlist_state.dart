part of 'chatlist_bloc.dart';

abstract class ChatlistState extends Equatable {
  const ChatlistState();

  @override
  List<Object> get props => [];
}

class ChatlistInitial extends ChatlistState {}

class ChatlistLoading extends ChatlistState {}

class ChatlistSuccess extends ChatlistState {
  ChatListModel chatListModel;
  String user_id;
  ChatlistSuccess({this.chatListModel, this.user_id});
  @override
  // TODO: implement props
  List<Object> get props => [this.chatListModel, this.user_id];
}

class ChatlistFailure extends ChatlistState {}

class ChatlistEmpty extends ChatlistState {}

part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  ChatModel chatModel;
  bool scrollDown;
  ChatSuccess({@required this.chatModel, @required this.scrollDown});
  @override
  List<Object> get props => [this.chatModel];
}

class ChatFailure extends ChatState {}

class ChatEmpty extends ChatState {}

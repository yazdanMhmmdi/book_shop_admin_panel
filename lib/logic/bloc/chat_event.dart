part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class GetChatMessagesREST extends ChatEvent {
  String book_id;
  GetChatMessagesREST({this.book_id});
  @override
  // TODO: implement props
  List<Object> get props => [this.book_id];
}

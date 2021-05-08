import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop_admin_panel/data/model/chat_model.dart';
import 'package:book_shop_admin_panel/data/repository/chat_repository.dart';
import 'package:book_shop_admin_panel/networking/api_provider.dart';
import 'package:book_shop_admin_panel/presentation/screen/login_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial());
  ChatRepository _chatRepository = new ChatRepository();
  // AccountRepository _accountRepository = new AccountRepository();
  String userId;
  ChatModel _model;
  int totalPage;
  String bookId;
  String fromId = "0";
  String conversationId = "0";
  var channel =
      IOWebSocketChannel.connect(Uri.parse("${ApiProvider.WEB_SOCKET}"));
  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is GetChatMessagesREST) {
      Stream _stream = channel.stream.asBroadcastStream();
      bookId = event.book_id;
      _stream.listen((event) {
        // add(SocketMessage(message: event, bookId: bookId));
      });

      yield ChatLoading();
      userId = user_id;
      try {
        _model =
            await _chatRepository.getChatMessages(userId, event.book_id);
        if (_model.chats.length == 0) {
          yield ChatEmpty();
        } else {
          totalPage = int.parse(_model.data.totalPages.toString());
          fromId = _model
              .chats[0].fromId; //get user id cause he send his id on user id
          conversationId = _model.chats[0].conversationId;

          yield ChatSuccess(chatModel: _model, scrollDown: false);
        }
      } catch (err) {
        yield ChatFailure();
      }
    }
  }
}

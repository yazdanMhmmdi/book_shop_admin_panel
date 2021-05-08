import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop_admin_panel/data/model/chatList_model.dart';
import 'package:book_shop_admin_panel/data/repository/chatlist_repository.dart';
import 'package:book_shop_admin_panel/presentation/screen/login_screen.dart';
import 'package:equatable/equatable.dart';

part 'chatlist_event.dart';
part 'chatlist_state.dart';

class ChatlistBloc extends Bloc<ChatlistEvent, ChatlistState> {
  ChatlistBloc() : super(ChatlistInitial());
  ChatlistRepository _repository = new ChatlistRepository();

  ChatListModel _model;
  int page = 1;
  int totalPage;
  @override
  Stream<ChatlistState> mapEventToState(
    ChatlistEvent event,
  ) async* {
    print("ChatlistInitial");
    if (event is GetChatlist) {
      try {
        yield ChatlistLoading();

        if (page == 1) {
          _model = await _repository.getChatList(user_id, page.toString());
          if (_model.chatsList.length == 0) {
            yield ChatlistEmpty();
            print("ChatlistEmpty");
          } else {
            totalPage = int.parse(_model.data.totalPages.toString());
            page++;
            yield ChatlistSuccess(chatListModel: _model, user_id: user_id);
            print("ChatlistSuccess");
          }
        } else if (page <= totalPage) {
          ChatListModel _tempModel =
              await _repository.getChatList(user_id, page.toString());
          _tempModel.chatsList.forEach((element) {
            _model.chatsList.add(element);
          });
          page++;
          yield ChatlistSuccess(chatListModel: _model, user_id: user_id);
          print("ChatlistSuccess");
        }
      } catch (err) {
        yield ChatlistFailure();
        print("ChatlistFailure");
      }
    }
  }
}

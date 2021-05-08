import 'package:book_shop_admin_panel/logic/bloc/chat_bloc.dart';
import 'package:book_shop_admin_panel/presentation/screen/login_screen.dart';
import 'package:book_shop_admin_panel/presentation/widget/from_message_bubble.dart';
import 'package:book_shop_admin_panel/presentation/widget/user_message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatTab extends StatefulWidget {
  Map<String, String> args;
  ChatTab({this.args});
  @override
  _ChatTabState createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  ChatBloc _chatBloc;
  String book_id;
  String userId;
  @override
  void initState() {
    _getArguments();

    _chatBloc = BlocProvider.of<ChatBloc>(context);
    _chatBloc.add(GetChatMessagesREST(book_id: book_id));
    userId = user_id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(26.0),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          child: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is ChatInitial) {
                return Container();
              } else if (state is ChatLoading) {
                return Container();
              } else if (state is ChatSuccess) {
                return ListView.builder(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 50),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.chatModel.chats.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        state.chatModel.chats[index].userId == userId
                            ? UserMessageBubble(
                                message: state.chatModel.chats[index].message,
                              )
                            : FromMessageBubble(
                                message: state.chatModel.chats[index].message,
                              ),
                      ],
                    );
                  },
                );
              } else if (state is ChatFailure) {
                return Container();
              } else if (state is ChatEmpty) {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  void _getArguments() {
    book_id = widget.args['book_id'];
  }
}

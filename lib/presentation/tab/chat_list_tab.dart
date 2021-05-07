import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/constants/strings.dart';
import 'package:book_shop_admin_panel/logic/bloc/chatlist_bloc.dart';
import 'package:book_shop_admin_panel/presentation/widget/chat_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListTab extends StatefulWidget {
  @override
  _ChatListTabState createState() => _ChatListTabState();
}

class _ChatListTabState extends State<ChatListTab> {
  ChatlistBloc _chatlistBloc;
  @override
  void initState() {
    _chatlistBloc = BlocProvider.of<ChatlistBloc>(context);
    _chatlistBloc.add(GetChatlist());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: SingleChildScrollView(
            child: BlocBuilder<ChatlistBloc, ChatlistState>(
              builder: (context, state) {
                if (state is ChatlistInitial) {
                  return Container();
                } else if (state is ChatlistLoading) {
                  return Container();
                } else if (state is ChatlistSuccess) {
                  List items = new List<Widget>();
                  state.chatListModel.chatsList.forEach((element) {
                    items.add(
                      ChatListItem(
                        id: element.id,
                        image: element.pictureThumb,
                        name: element.name,
                        writer: element.writer,
                        thumbImage: element.pictureThumb,
                        voteCount: double.parse(element.voteCount),
                        price: element.price,
                        newMessageCount: element.newMessageCount,
                        userId: state.user_id,
                      ),
                    );
                  });
                  return Wrap(
                    children: items,
                  );
                } else if (state is ChatlistFailure) {
                  return Container();
                } else if (state is ChatlistEmpty) {
                  return Container(
                    child: Center(
                      child: Text(
                        "کتابی وجود ندارد",
                        style: TextStyle(
                            color: IColors.black55,
                            fontFamily: Strings.fontIranSans,
                            fontSize: 16),
                      ),
                    ),
                  );
                }
              },
            ),
          )),
    );
  }
}

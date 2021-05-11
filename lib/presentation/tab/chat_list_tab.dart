import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/constants/strings.dart';
import 'package:book_shop_admin_panel/logic/bloc/chat_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/chatlist_bloc.dart';
import 'package:book_shop_admin_panel/logic/bloc/tabslider_bloc.dart';
import 'package:book_shop_admin_panel/presentation/tab/chat_tab.dart';
import 'package:book_shop_admin_panel/presentation/widget/chat_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListTab extends StatefulWidget {
  static String from_id;
  @override
  _ChatListTabState createState() => _ChatListTabState();
}

class _ChatListTabState extends State<ChatListTab> {
  ChatlistBloc _chatlistBloc;
  TabsliderBloc _tabSliderBloc;
  ChatBloc _chatBloc;
  @override
  void initState() {
    _chatlistBloc = BlocProvider.of<ChatlistBloc>(context);
    _tabSliderBloc = BlocProvider.of<TabsliderBloc>(context);
    _chatBloc = BlocProvider.of<ChatBloc>(context);
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
                  return Container(
                    child: Center(child: CircularProgressIndicator()),
                    height: MediaQuery.of(context).size.height,
                  );
                } else if (state is ChatlistSuccess) {
                  List items = new List<Widget>();
                  state.chatListModel.chatsList.forEach((element) {
                    items.add(
                      ChatListItem(
                          id: element.bookIdNum,
                          image: element.pictureThumb,
                          name: element.name,
                          writer: element.writer,
                          thumbImage: element.pictureThumb,
                          voteCount: double.parse(element.voteCount),
                          price: element.price,
                          newMessageCount: element.newMessageCount,
                          userId: state.user_id,
                          fromId: element.userId,
                          onTap: () {
                            ChatListTab.from_id = element.userId;
                            _tabSliderBloc.add(MoveForwardEvent(
                                args: <String, String>{
                                  "book_id": element.bookIdNum,
                                  "from_id": element.fromId,
                                },
                                tab: 4,
                                tabSliderBloc: _tabSliderBloc,
                                chatBloc: _chatBloc));
                          }),
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

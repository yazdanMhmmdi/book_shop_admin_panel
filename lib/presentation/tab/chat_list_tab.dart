import 'package:book_shop_admin_panel/presentation/widget/chat_list_item.dart';
import 'package:flutter/material.dart';

class ChatListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Wrap(
                  children: [
                    ChatListItem(
                        id: "1",
                        image: "image",
                        name: "name",
                        writer: "writer",
                        thumbImage: "thumbImage",
                        voteCount: 1,
                        price: "2222",
                        newMessageCount: "newMessageCount",
                        userId: "2")
                  ],
                )
              ],
            ),
          )),
    );
  }
}

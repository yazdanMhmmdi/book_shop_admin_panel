import 'package:book_shop_admin_panel/presentation/widget/from_message_bubble.dart';
import 'package:book_shop_admin_panel/presentation/widget/user_message_bubble.dart';
import 'package:flutter/material.dart';

class ChatTab extends StatefulWidget {
  @override
  _ChatTabState createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(26.0),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              FromMessageBubble(message: "sad"),
              UserMessageBubble(
                message: "xxsad",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

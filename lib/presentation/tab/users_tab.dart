import 'package:book_shop_admin_panel/data/repository/users_repository.dart';
import 'package:book_shop_admin_panel/presentation/widget/user_item.dart';
import 'package:flutter/material.dart';

class UsersTab extends StatefulWidget {
  static int clickStatus;

  @override
  _UsersTabState createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(26.0),
      child: Wrap(
        children: [
          UserItem(
            id: "0",
            name: "رضا محمدی",
            username: "Yazdanm68",
            number: 0,
            onTap: () async {
              setState(() {
                UsersTab.clickStatus = 0;
                print('xx1');
              });
              UsersRepository _repo = new UsersRepository();
              var res = await _repo.getUsers("1");
              print(res.users[0].username);
            },
          ),
          UserItem(
            id: "1",
            name: "جلال محمدی",
            username: "Jalal767",
            number: 1,
            onTap: () {
              setState(() {
                UsersTab.clickStatus = 1;
                print('xx1');
              });
            },
          ),
        ],
      ),
    );
  }
}

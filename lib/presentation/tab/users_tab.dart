import 'package:book_shop_admin_panel/data/repository/users_repository.dart';
import 'package:book_shop_admin_panel/logic/bloc/users_bloc.dart';
import 'package:book_shop_admin_panel/presentation/screen/panel_screen.dart';
import 'package:book_shop_admin_panel/presentation/widget/user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersTab extends StatefulWidget {
  static int clickStatus;

  @override
  _UsersTabState createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  UsersBloc _usersBloc;
  @override
  void initState() {
    _usersBloc = BlocProvider.of<UsersBloc>(context);
    _usersBloc.add(DisposeUsersEvent());
    _usersBloc.add(GetUsersEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(26.0),
      child: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersInitial) {
            return Container();
          } else if (state is UsersLoading) {
            return Container(
                height: MediaQuery.of(context).size.height,
                child: Center(child: CircularProgressIndicator()));
          } else if (state is UsersSuccess) {
            List items = new List<Widget>();
            state.usersModel.users.forEach((element) {
              items.add(UserItem(
                id: "${element.id}",
                name: "${element.username}",
                username: "${element.password}",
                number: int.parse(element.id),
                onTap: () async {
                  setState(() {
                    UsersTab.clickStatus = int.parse(element.id);
                    print('xx1');
                  });
                  _usersBloc.add(SelectUsersEvent(user_id: element.id));
                },
              ));
            });
            return Wrap(children: items);
          } else if (state is UsersLazyLoading) {
            List items = new List<Widget>();
            state.usersModel.users.forEach((element) {
              items.add(UserItem(
                id: "${element.id}",
                name: "${element.username}",
                username: "${element.password}",
                number: int.parse(element.id),
                onTap: () async {
                  setState(() {
                    UsersTab.clickStatus = int.parse(element.id);

                    print('xx1');
                  });
                  _usersBloc.add(SelectUsersEvent(user_id: element.id));
                },
              ));
            });
            return Wrap(children: items);
          } else if (state is ReturnSelectedUser) {
            List items = new List<Widget>();
            state.usersModel.users.forEach((element) {
              items.add(UserItem(
                id: "0",
                name: "${element.username}",
                username: "${element.password}",
                number: int.parse(element.id),
                onTap: () async {
                  setState(() {
                    UsersTab.clickStatus = int.parse(element.id);

                    print('xx1');
                  });
                  _usersBloc.add(SelectUsersEvent(user_id: element.id));
                },
              ));
            });
            return Wrap(children: items);
          } else if (state is UsersFailure) {
            return Container();
          }
        },
      ),
    );
  }
}

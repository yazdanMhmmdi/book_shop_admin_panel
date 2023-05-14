import 'package:book_shop_admin_panel/core/constants/assets.dart';
import 'package:book_shop_admin_panel/core/utils/image_address_provider.dart';
import 'package:book_shop_admin_panel/data/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/i_colors.dart';
import '../../../core/constants/strings.dart';
import '../../../data/models/book_model.dart';
import '../my_rating_bar.dart';
import '../slidable_action.dart';

class UserItemMobile extends StatelessWidget {
  UserModel? userModel;
  late Function(BuildContext context) onDelete;
  late Function(BuildContext context) onEdit;

  UserItemMobile({
    required this.userModel,
    required this.onDelete,
    required this.onEdit,
  });
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          MySlidableAction(
            label: 'حذف',
            backgroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: onDelete,
          ),
          MySlidableAction(
            label: 'ویرایش',
            backgroundColor: Colors.blue,
            icon: Icons.edit,
            onPressed: onEdit,
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          MySlidableAction(
            label: 'حذف',
            backgroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: onDelete,
          ),
          MySlidableAction(
            label: 'ویرایش',
            backgroundColor: Colors.blue,
            icon: Icons.edit,
            onPressed: onEdit,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Container(
          height: 102,
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8)),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              splashColor: Colors.black12,
              onTap: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(11),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.transparent,
                          image: const DecorationImage(
                            image: AssetImage(
                              Assets.user_ico,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Builder(builder: (BuildContext context) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width - 160,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 26),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  userModel!.username!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontFamily: "IranSans",
                                      fontSize: 16,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  userModel!.password!,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: "IranSans",
                                      fontSize: 14,
                                      color: Colors.black38),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
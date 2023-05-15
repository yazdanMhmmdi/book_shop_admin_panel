import 'package:book_shop_admin_panel/core/utils/image_address_provider.dart';
import 'package:book_shop_admin_panel/presentation/animations/fade_in_animation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/i_colors.dart';
import '../../../core/constants/strings.dart';
import '../../../data/models/book_model.dart';
import '../my_rating_bar.dart';
import '../slidable_action.dart';

class BookItemMobile extends StatelessWidget {
  BookModel? bookModel;
  late Function(BuildContext context) onDelete;
  late Function(BuildContext context) onEdit;
  int index = 1;
  BookItemMobile({
    required this.bookModel,
    required this.onDelete,
    required this.onEdit,
  });
  @override
  Widget build(BuildContext context) {
    return FadeInAnimation(
      0.25 + ((index + 1) * 0.3),
      Slidable(
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
            height: 142,
            decoration: BoxDecoration(
                color:
                    Colors.blue.withOpacity(0.15), // TODO: Needs to be replace;
                borderRadius: BorderRadius.circular(8)),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                splashColor: Colors.black12,
                onTap: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(11),
                      child: Container(
                        width: 81,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                offset: const Offset(7, 7),
                                blurRadius: 10)
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.transparent,
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  bookModel!.pictureThumb!,
                                ),
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
                                children: [
                                  Text(
                                    bookModel!.name!,
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
                                    bookModel!.writer!,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontFamily: "IranSans",
                                        fontSize: 14,
                                        color: Colors.black38),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  MyRatingBar(bookModel!.voteCount!, 13),
                                ],
                              ),
                              Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: Text(
                                    NumberFormat("#,##0.##").format(
                                            double.parse(
                                                bookModel!.price.toString())) +
                                        " تومان",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: Strings.fontIranSans,
                                        color: IColors.boldGreen,
                                        fontWeight: FontWeight.w700),
                                  )),
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
      ),
    );
  }
}

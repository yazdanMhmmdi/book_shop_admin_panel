import 'package:book_shop_admin_panel/constants/i_colors.dart';
import 'package:book_shop_admin_panel/constants/strings.dart';
import 'package:book_shop_admin_panel/networking/image_address_provider.dart';
import 'package:book_shop_admin_panel/presentation/tab/books_tab.dart';
import 'package:book_shop_admin_panel/presentation/widget/custom_agent_widget.dart';
import 'package:book_shop_admin_panel/presentation/widget/image_holder.dart';
import 'package:book_shop_admin_panel/presentation/widget/regular_item_bar.dart';
import 'package:book_shop_admin_panel/presentation/widget/top_right_book_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatListItem extends StatelessWidget {
  String image;
  String name, writer, thumbImage;
  String id;
  double voteCount;
  String price;
  String newMessageCount;
  String userId;
  String fromId;
  Function onTap;

  ChatListItem({
    @required this.id,
    @required this.image,
    @required this.name,
    @required this.writer,
    @required this.thumbImage,
    @required this.voteCount,
    @required this.price,
    @required this.newMessageCount,
    @required this.userId,
    @required this.onTap,
    @required this.fromId,
  });

  @override
  Widget build(BuildContext context) {
    print("star :  ${voteCount}");
    return Padding(
      padding: const EdgeInsets.only(left: 26, bottom: 26),
      child: AnimatedContainer(
        duration: Duration(
          milliseconds: 300,
        ),
        width: 125,
        height: 247,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: IColors.lowBoldGreen,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            // splashFactory: InkRipple.splashFactory,
            borderRadius: BorderRadius.circular(8),
            splashColor: IColors.black15,
            onTap: onTap,
            // doubleTapTime: Duration(milliseconds: 300),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: TopRightBookWidget(
                        id: id,
                        number: int.parse(id),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(
                        milliseconds: 300,
                      ),
                      width: 54,
                      height: 26,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(8),
                              topLeft: Radius.circular(8)),
                          color: BooksTab.clickStatus == int.parse(id)
                              ? IColors.green
                              : IColors.boldGreen),
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: Duration(milliseconds: 300),
                          style: TextStyle(
                            color: BooksTab.clickStatus == int.parse(id)
                                ? Colors.white70
                                : IColors.black85,
                            fontFamily: Strings.fontIranSans,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.person),
                              Text(
                                '${fromId}',
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                ImageHolder(
                  address: ImageAddressProvider.imageURL + thumbImage,
                ),
                SizedBox(height: 12),
                Container(
                  width: 95,
                  child: Text(
                    "${name}",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: Strings.fontIranSans,
                      fontSize: 16,
                      color: IColors.black85,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  width: 95,
                  child: Text(
                    "${writer}",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: Strings.fontIranSans,
                      fontSize: 14,
                      color: IColors.black35,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                RegularRatingBar(rate: voteCount),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

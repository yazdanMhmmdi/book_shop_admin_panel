import 'dart:async';
import 'dart:io';
import 'package:book_shop_admin_panel/core/constants/constants.dart';
import 'package:book_shop_admin_panel/presentation/widgets/category_drowp_down_widget/category_drop_down_widget_mobile.dart';
import 'package:book_shop_admin_panel/presentation/widgets/category_drowp_down_widget/category_dropdown_widget_desktop.dart';
import 'package:book_shop_admin_panel/presentation/widgets/custom_dropdown_widget.dart';
import 'package:book_shop_admin_panel/presentation/widgets/custom_scroll_behavior.dart';
import 'package:book_shop_admin_panel/presentation/widgets/edit_multi_text_field.dart';
import 'package:book_shop_admin_panel/presentation/widgets/edit_page_banner_image_mobile.dart';
import 'package:book_shop_admin_panel/presentation/widgets/edit_text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/i_colors.dart';
import '../../../core/constants/strings.dart';
import '../../../core/utils/image_address_provider.dart';
import '../../../core/utils/map_categories.dart';
import '../../bloc/books_bloc.dart';
import '../../cubit/detail_cubit.dart';
import '../../cubit/internet_cubit.dart';
import '../../widgets/detail_slider_container.dart';
import '../../widgets/detail_slider_item.dart';
import '../../widgets/detail_slider_widget.dart';
import '../../widgets/global_class.dart';
import '../../widgets/image_picker_widget.dart';
import '../../widgets/my_button.dart';
import '../../widgets/price_text_field_mobile.dart';
import '../../widgets/progress_button.dart';

class EditPageMobile extends StatefulWidget {
  EditPageMobile();

  @override
  State<EditPageMobile> createState() => _EditPageMobileState();
}

class _EditPageMobileState extends State<EditPageMobile> {
  Color backgroundColor = IColors.green;

  late DetailCubit _animationCubit;

  TextEditingController bookNameController = TextEditingController();
  TextEditingController bookWriterController = TextEditingController();
  TextEditingController bookLanguageController = TextEditingController();
  TextEditingController bookPageCountController = TextEditingController();
  TextEditingController bookVoteController = TextEditingController();
  TextEditingController bookSellCountController = TextEditingController();
  TextEditingController bookDescController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController customDropDownController = TextEditingController()
    ..text = Strings.categoryOptionPhyisical;

  CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    customPattern: customCurrencyPattern,
    decimalDigits: 0,
  );
  ButtonState buttonState = ButtonState.idle;
  BooksBloc? booksBloc;
  final GlobalKey<EditPageBannerImageMobileState> _bannerImageKey = GlobalKey();

  @override
  void initState() {
    booksBloc = BlocProvider.of<BooksBloc>(context);
    _animationCubit = BlocProvider.of<DetailCubit>(context);
    GlobalClass.file = File(Assets.bookPlaceHolder);
    booksBloc!.add(ResetEvent());

    super.initState();

    priceController.addListener(() {
      _formatter.format(priceController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    // _detailsBloc.add(GetDetails(post_id: arguments["post_id"]));
    _animationCubit.initializeAnimations(context);

    // _getArguments();

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: BlocBuilder<InternetCubit, InternetState>(
        builder: (context, state) {
          if (state is InternetConnected) {
            return Scaffold(
              backgroundColor: IColors.green,
              body: OrientationBuilder(builder: (context, orientation) {
                return Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top + 16,
                              right: 24.0),
                          child: IconButton(
                            iconSize: 30,
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              //close button
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    ScrollConfiguration(
                      behavior: CustomScrollBehavior(),
                      child: BlocBuilder<DetailCubit, DetailState>(
                        builder: (context, state) {
                          if (state is DetailStatus) {
                            return NotificationListener<
                                DraggableScrollableNotification>(
                              onNotification: (notification) {
                                _animationCubit.noto(notification);
                                return false;
                              },
                              child: DraggableScrollableSheet(
                                initialChildSize: 0.75,
                                minChildSize: 0.75,
                                builder: (context, scroll) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(double.parse(
                                            state.borderRadius.toString())),
                                        topRight: Radius.circular(double.parse(
                                            state.borderRadius.toString()))),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              offset: const Offset(1, -1),
                                              blurRadius: 4,
                                              color: IColors.borderShadow,
                                            )
                                          ]),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: ListView(
                                          controller: scroll,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24),
                                          children: [
                                            const SizedBox(
                                              height: 120,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 32),
                                                  child: ImagePickerWidget(
                                                    imgUrl: "",
                                                    onFilePicked: (file) {
                                                      GlobalClass.file = file;
                                                      _bannerImageKey
                                                          .currentState!
                                                          .refresh();
                                                    },
                                                  ),
                                                ),
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  child:
                                                      CategoryDropdownWidgetMobile(
                                                    width: 160,
                                                    selectedValue: MapCategories
                                                        .returnTitle(GlobalClass
                                                            .currentCategoryId),
                                                    title: "",
                                                    optionList: categoryList,
                                                    selectedValueChange: (val) {
                                                      GlobalClass
                                                              .currentCategoryId =
                                                          val;
                                                      // booksBloc!
                                                      //     .add(ResetEvent());
                                                      // booksBloc!.add(FetchEvent(
                                                      //     category: GlobalClass
                                                      //         .currentCategoryId));
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            EditTextField(
                                                width: double.infinity,
                                                controller: bookNameController,
                                                obscureText: false,
                                                icon: Icons.title,
                                                isOnlyDigit: false,
                                                text:
                                                    "نام کتاب را وارد کنید...",
                                                textFieldColor:
                                                    IColors.lowBoldGreen),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            EditTextField(
                                                width: double.infinity,
                                                controller:
                                                    bookWriterController,
                                                obscureText: false,
                                                icon: Icons.person,
                                                isOnlyDigit: false,
                                                text:
                                                    "نام نویسنده را وارد کنید...",
                                                textFieldColor:
                                                    IColors.lowBoldGreen),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: EditTextField(
                                                      width: 200,
                                                      controller:
                                                          bookLanguageController,
                                                      obscureText: false,
                                                      icon: Icons.language,
                                                      isOnlyDigit: false,
                                                      text:
                                                          "زبان را وارد کنید...",
                                                      textFieldColor:
                                                          IColors.lowBoldGreen),
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Directionality(
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    child: CustomDropdownWidget(
                                                        selectedValueChange:
                                                            (val) {
                                                          customDropDownController
                                                              .text = val;
                                                        },
                                                        title: "",
                                                        selectedValue:
                                                            customDropDownController
                                                                .text,
                                                        optionList: const [
                                                          Strings
                                                              .categoryOptionPhyisical,
                                                          Strings
                                                              .categoryOptionDigital,
                                                        ]),
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: EditTextField(
                                                      width: 200,
                                                      controller:
                                                          bookPageCountController,
                                                      obscureText: false,
                                                      icon: Icons.book,
                                                      isOnlyDigit: false,
                                                      maxLengh: 5,
                                                      text:
                                                          "تعداد صفحات را وارد کنید...",
                                                      textFieldColor:
                                                          IColors.lowBoldGreen),
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: EditTextField(
                                                      width: 200,
                                                      controller:
                                                          bookVoteController,
                                                      obscureText: false,
                                                      icon: Icons.favorite,
                                                      isOnlyDigit: true,
                                                      maxLengh: 3,
                                                      onChanged: (val) {
                                                        if (val.isNotEmpty) {
                                                          if (double.parse(
                                                                  val) >=
                                                              5.0) {
                                                            bookVoteController
                                                                .text = "5";
                                                          }
                                                        }
                                                      },
                                                      text:
                                                          "تعداد رای  را وارد کنید...",
                                                      textFieldColor:
                                                          IColors.lowBoldGreen),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: EditTextField(
                                                      width: 200,
                                                      controller:
                                                          bookSellCountController,
                                                      maxLengh: 9,
                                                      obscureText: false,
                                                      icon:
                                                          Icons.shopping_basket,
                                                      text:
                                                          "تعداد فروش را وارد کنید...",
                                                      textFieldColor:
                                                          IColors.lowBoldGreen),
                                                ),
                                                const SizedBox(
                                                  width: 16,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: PriceTextFieldMobile(
                                                      width: 200,
                                                      controller:
                                                          priceController..text,
                                                      obscureText: false,
                                                      maxLengh: 16,
                                                      icon: Icons.price_change,
                                                      text:
                                                          "قیمت را وارد کنید...",
                                                      textFieldColor:
                                                          IColors.lowBoldGreen),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            EditMultiTextField(
                                                controller: bookDescController,
                                                obscureText: false,
                                                icon: Icons.description,
                                                text:
                                                    "توضیحات کتاب را وارد کنید...",
                                                textFieldColor:
                                                    IColors.lowBoldGreen,
                                                width: double.infinity),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            BlocBuilder<BooksBloc, BooksState>(
                                              builder: (context, state) {
                                                if (state is BooksLoading) {
                                                  return myButton(
                                                      buttonState:
                                                          ButtonState.loading);
                                                } else if (state
                                                    is BooksFailure) {
                                                  return myButton(
                                                      buttonState:
                                                          ButtonState.fail);
                                                } else if (state
                                                    is BooksSuccess) {
                                                  return myButton(
                                                      buttonState:
                                                          ButtonState.success);
                                                } else if (state
                                                    is BooksInitial) {
                                                  return myButton(
                                                      buttonState:
                                                          ButtonState.idle);
                                                } else {
                                                  return myButton(
                                                      buttonState:
                                                          ButtonState.idle);
                                                }
                                              },
                                            ),
                                            const SizedBox(
                                              height: 32,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                    IgnorePointer(
                      child: BlocBuilder<DetailCubit, DetailState>(
                        builder: (context, state) {
                          if (state is DetailStatus) {
                            return Opacity(
                              opacity: state.percent,
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: ((orientation ==
                                                      Orientation.portrait
                                                  ? 10.h
                                                  : 5.h) *
                                              state.percent)),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: 87,
                                            height: 200,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.transparent,
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset:
                                                          const Offset(0, 12),
                                                      blurRadius: 22,
                                                      color: Colors.black
                                                          .withOpacity(0.25))
                                                ]),
                                          ),
                                          EditPageBannerImageMobile(
                                            key: _bannerImageKey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ],
                );
              }),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    booksBloc!.close();
    _animationCubit.close();
    customDropDownController.clear();
    bookNameController.clear();
    super.dispose();
  }

  Widget myButton({ButtonState buttonState = ButtonState.idle}) {
    return MyButton(
        buttonState: buttonState,
        text: "افزودن کتاب",
        onTap: () {
          booksBloc!.add(AddEvent(
              categoryId: GlobalClass.currentCategoryId,
              coverType: customDropDownController.text,
              description: bookDescController.text,
              language: bookLanguageController.text,
              name: bookNameController.text,
              pagesCount: bookPageCountController.text,
              price: _formatter.getUnformattedValue().toString(),
              salesCount: bookSellCountController.text,
              voteCount: bookVoteController.text,
              writer: bookWriterController.text,
              pictureFile: GlobalClass.file));
        });
  }
}

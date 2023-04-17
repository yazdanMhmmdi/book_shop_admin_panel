import 'dart:io';

import 'package:book_shop_admin_panel/core/constants/assets.dart';
import 'package:book_shop_admin_panel/core/params/request_params.dart';
import 'package:book_shop_admin_panel/core/utils/typogaphy.dart';
import 'package:book_shop_admin_panel/data/models/book_model.dart';
import 'package:book_shop_admin_panel/domain/usecases/edit_books_usecase.dart';
import 'package:book_shop_admin_panel/presentation/bloc/books_bloc.dart';
import 'package:book_shop_admin_panel/presentation/widgets/category_dropdown_widget.dart';
import 'package:book_shop_admin_panel/presentation/widgets/global_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../../core/constants/i_colors.dart';
import '../../../core/constants/strings.dart';
import '../../../injector.dart';
import '../custom_dropdown_widget.dart';
import '../image_picker_widget.dart';

//base dialog is EditDialog
class AddBookDialog extends StatefulWidget {
  AddBookDialog();
  @override
  _EditBookDialogState createState() => _EditBookDialogState();
}

class _EditBookDialogState extends State<AddBookDialog> {
  BooksBloc? _booksBloc;

  static File? file = File(Assets.bookPlaceHolder);

  String? name;

  String? writer;

  String? description;

  String? language;

  String? coverType;

  String? pageCount;

  String? vote;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _writerController = new TextEditingController();
  String? _coverType = Strings.categoryOptionPhyisical;
  String? _categoryTypeId = categoryList[0]['category_id'];

  TextEditingController _languageController = new TextEditingController();

  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _voteCountController = new TextEditingController();
  TextEditingController _pageCountController = new TextEditingController();
  TextEditingController _categoryController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _booksBloc = BlocProvider.of<BooksBloc>(context);
    // _booksBloc!.add(ReturnSelectedBookEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(38),
            boxShadow: [
              BoxShadow(
                offset: Offset(1, -1),
                blurRadius: 4,
                spreadRadius: 0,
                color: IColors.black15,
              ),
            ]),
        child: objects());
  }

  Widget objects() {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            children: [
              textField("نویسنده", 377, _writerController..text, 50),
              SizedBox(width: 16),
              textField("موضوع کتاب", 377, _nameController..text, 50)
            ],
          ),
          SizedBox(height: 16),
          multiTextField("توضیحات", _descriptionController..text, 560),
          SizedBox(
            height: 16,
          ),
          Wrap(
            children: [
              CustomDropdownWidget(
                  selectedValueChange: (val) {
                    _coverType = val;
                  },
                  title: "نوع جلد",
                  selectedValue: _coverType,
                  optionList: const [
                    Strings.categoryOptionPhyisical,
                    Strings.categoryOptionDigital,
                  ]),
              SizedBox(width: 16),
              textField("زبان  ", 377, _languageController..text, 15),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Wrap(
            children: [
              textField("رای  ", 377, _voteCountController..text, 3,
                  textInputType: TextInputType.number,
                  isOnlyDigit: true, onChanged: (val) {
                if (val.isNotEmpty) {
                  if (double.parse(val) >= 5.0) {
                    _voteCountController.text = "5";
                  }
                }
              }),
              SizedBox(width: 16),
              textField(
                "تعداد صفحات",
                377,
                _pageCountController..text,
                4,
                textInputType: TextInputType.number,
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ImagePickerWidget(
                imgUrl: "",
                onFilePicked: (file) {
                  GlobalClass.file = file;
                },
              ),
              const SizedBox(width: 16),
              // textField("شماره دسته بندی  ", 377, _categoryController..text, 6),
              CategoryDropdownWidget(
                selectedValue: Strings.categoryOptionSicence,
                title: "دسته بندی",
                optionList: categoryList,
                selectedValueChange: (val) {
                  _categoryTypeId = val;
                },
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Text(
              ".اگر عکسی انتخاب نکنید پیش نمایشی به عنوان عکس پیش فرض قرار خواهد گرفت",
              style: Typogaphy.Regular.copyWith(
                color: IColors.black35,
                fontSize: 14,
                decoration: TextDecoration.none,
              )),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 38,
            width: 770,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: IColors.boldGreen,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.black26,
                borderRadius: BorderRadius.circular(8),
                onTap: () async {
                  _booksBloc!.add(AddEvent(
                      pictureFile: GlobalClass.file,
                      categoryId: _categoryTypeId,
                      coverType: _coverType,
                      description: _descriptionController.text,
                      language: _languageController.text,
                      name: _nameController.text,
                      pagesCount: _pageCountController.text,
                      voteCount: _voteCountController.text,
                      writer: _writerController.text));
                  // EditBookUsecase usecase = EditBookUsecase(sl());
                  // var s = await usecase(EditBookRequestParams(
                  //     pictureFile: GlobalClass.file,
                  //     bookId: widget.bookModel!.id,
                  //     coverType: widget.bookModel!.coverType,
                  //     description: widget.bookModel!.description,
                  //     language: widget.bookModel!.language,
                  //     name: widget.bookModel!.name,
                  //     pagesCount: widget.bookModel!.pagesCount,
                  //     voteCount: widget.bookModel!.voteCount.toString(),
                  //     writer: widget.bookModel!.writer));
                  setState(() {
                    GlobalClass.file = File('');
                  });
                  Navigator.pop(context);
                },
                child: const Center(
                  child: Text(
                    "افزودن کتاب",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontFamily: Strings.fontIranSans,
                        fontSize: 16,
                        color: Colors.white70,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget textField(
      String title, double width, TextEditingController controller, maxLengh,
      {Function(String)? onChanged,
      TextInputType? textInputType,
      bool? isOnlyDigit}) {
    onChanged ??= onChanged = (v) {
      return '';
    };
    textInputType ??= TextInputType.text;
    isOnlyDigit ??= false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          " ${title}",
          style: TextStyle(
              fontSize: 16,
              fontFamily: Strings.fontIranSans,
              color: IColors.black85,
              decoration: TextDecoration.none),
        ),
        SizedBox(
          height: 8,
        ),
        Material(
          child: Container(
            height: 35,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: IColors.lowBoldGreen,
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Center(
                  child: TextField(
                controller: controller,
                onChanged: onChanged,
                maxLines: 1,
                keyboardType: textInputType,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(maxLengh),
                  isOnlyDigit
                      ? FilteringTextInputFormatter.allow(
                          RegExp(r'^[0-9]+\.?[0-9]*'))
                      : FilteringTextInputFormatter.singleLineFormatter,
                ],
                style: const TextStyle(fontFamily: 'IranSans', fontSize: 16),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(bottom: 16, right: 16, left: 16)),
              )),
            ),
          ),
        ),
      ],
    );
  }

  Widget multiTextField(
      String title, TextEditingController controller, int maxLengh) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          " ${title}",
          style: TextStyle(
              fontSize: 16,
              fontFamily: Strings.fontIranSans,
              color: IColors.black85,
              decoration: TextDecoration.none),
        ),
        SizedBox(
          height: 8,
        ),
        Material(
          color: Colors.transparent,
          child: Container(
            height: 92,
            width: 770,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: IColors.lowBoldGreen,
            ),
            child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  maxLines: 3,
                  controller: controller,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(maxLengh),
                  ],
                  style:
                      TextStyle(fontFamily: Strings.fontIranSans, fontSize: 16),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          bottom: 11, right: 16, left: 16, top: 11)),
                )),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

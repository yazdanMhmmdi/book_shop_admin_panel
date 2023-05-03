import 'package:flutter/material.dart';

import 'global_class.dart';

class EditPageBannerImageMobile extends StatefulWidget {
  const EditPageBannerImageMobile({Key? key}) : super(key: key);

  @override
  EditPageBannerImageMobileState createState() =>
      EditPageBannerImageMobileState();
}

class EditPageBannerImageMobileState extends State<EditPageBannerImageMobile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 136,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        image: DecorationImage(
            fit: BoxFit.fill, image: FileImage(GlobalClass.file!)),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ImageConverter {
  static Future<File> fileFromImageUrl(String url) async {
    imageCache.clear();

    var response = await http.get(Uri.parse(url));

    var documentDirectory = await getApplicationDocumentsDirectory();

    File file = File(join(documentDirectory.path, 'imagetest.png'));

    file.writeAsBytesSync(response.bodyBytes);

    return file;
  }
}

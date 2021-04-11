import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiProvider {
  static const String URL_IP = "localhost"; //yazdanmohammadi.ir
  final String _BASE_URL = "http://$URL_IP/book_shop/api/admin/";
  final String _IMAGE_URL = "http://$URL_IP";

  Future<dynamic> get(String url) async {
    try {
      final response = await http.get(_BASE_URL + url);
      return await decodeResponse(response);
    } catch (_) {
      print('connection failure $_BASE_URL' + url);
    }
  }

  Future<dynamic> post(
      String url, File file, Map<String, String> params) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(_BASE_URL + url));
      Map<String, String> headers = {"Content-type": "multipart/form-data"};
      request.files.add(
        http.MultipartFile(
          'picture',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: 'xxsaxas.jpg',
        ),
      );
      request.headers.addAll(headers);
      request.fields.addAll(params);
      print("request: " + request.toString());
      var res = await request.send();
      Response response = await http.Response.fromStream(res);
      print("response: ${response.body}");

      return await decodeResponse(response);
    } catch (_) {
      print('${_.toString()} connection failure $_BASE_URL' + url);
    }
  }

  dynamic decodeResponse(response) {
    try {
      return json.decode(response.body);
    } catch (_) {
      print("json decoding failure");
    }
  }
  // decodeResponse(bool utf8Support, response) {
  //   if (utf8Support) {
  //     return json.decode(utf8.decode(response.bodyBytes));
  //   } else {
  //     return json.decode(response.body.toString());
  //   }
  // }
}

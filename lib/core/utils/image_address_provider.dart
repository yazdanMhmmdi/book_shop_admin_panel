import '../constants/constants.dart';

class ImageAddressProvider {
  static final String imageURL = kBaseApiUrl! ;
  String? address;
  ImageAddressProvider._();
  static String getAddress(String? address) {
    return kBaseApiUrl! + address!;
  }
}

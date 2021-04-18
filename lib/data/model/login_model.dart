class LoginModel {
  String error;
  String errorMessage;
  String userId;

  LoginModel({this.error, this.errorMessage, this.userId});

  LoginModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    errorMessage = json['error_message'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['error_message'] = this.errorMessage;
    data['user_id'] = this.userId;
    return data;
  }
}

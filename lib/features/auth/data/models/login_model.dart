class LoginModel {
  String? sId;
  String? accessToken;
  String? refreshToken;

  LoginModel({this.sId, this.accessToken, this.refreshToken});

  LoginModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }
}

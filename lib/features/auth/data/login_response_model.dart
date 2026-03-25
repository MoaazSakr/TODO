import 'package:todo/features/auth/data/user_model.dart';

class LoginResponseModel{
  String? accessToken;
  String? refreshToken;
  bool? status;
  UserModel? userModel;
  String? password;
  LoginResponseModel({this.accessToken, this.refreshToken, this.status, this.userModel});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    status = json['status'];
    userModel = UserModel.fromJson(json['user']);
    password = json['password'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['status'] = status;
    if (userModel != null) {
      data['user'] = userModel!.toJson();
    }
    return data;
  } 
}
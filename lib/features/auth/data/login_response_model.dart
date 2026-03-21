import 'package:todo/features/auth/data/user_model.dart';

class LoginResponseModel{
  String? accessToken;
  String? refreshToken;
  bool? status;
  UserModel? userModel;

  LoginResponseModel({this.accessToken, this.refreshToken, this.status, this.userModel});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    status = json['status'];
    userModel = UserModel.fromJson(json['user']);
  }

}
import 'package:todo/features/auth/data/user_model.dart';

class RegisterResponseModel{
  bool? status;
  UserModel? userModel;
  String? accessToken;
  String? refreshToken;

  RegisterResponseModel({this.status, this.userModel});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      status: json['status'],
      userModel: UserModel.fromJson(json['user'])
    );
  }

}
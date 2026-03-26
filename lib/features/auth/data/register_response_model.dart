import 'package:todo/features/auth/data/user_model.dart';

class RegisterResponseModel {
  bool? status;
  UserModel? userModel;
  String? accessToken;
  String? refreshToken;

  RegisterResponseModel({this.status, this.userModel, this.accessToken, this.refreshToken});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    var model = RegisterResponseModel(
      status: json['status'],
      userModel: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
    
    model.accessToken = json['access_token'];
    model.refreshToken = json['refresh_token'];
    
    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    if (userModel != null) {
      data['user'] = userModel!.toJson();
    }
    return data;
  }
}
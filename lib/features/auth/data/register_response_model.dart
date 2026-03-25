import 'package:todo/features/auth/data/user_model.dart';

class RegisterResponseModel {
  bool? status;
  UserModel? userModel;
  String? accessToken;
  String? refreshToken;

  RegisterResponseModel({this.status, this.userModel});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      status: json['status'],
      userModel: UserModel.fromJson(json['user']),
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (userModel != null) {
      data['user'] = userModel!.toJson();
    }
    return data;
  }
}

import 'package:eventhub_app/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String access,
    required String refresh,
    required dynamic userinfo,
  }) : super(
          access: access,
          refresh: refresh,
          userinfo: userinfo,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      access: json['access'],
      refresh: json['refresh'],
      userinfo: json['user'],
    );
  }
}

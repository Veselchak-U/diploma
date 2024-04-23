import 'package:json_annotation/json_annotation.dart';

part 'login_api_model.g.dart';

@JsonSerializable(createToJson: false)
class LoginApiModel {
  final int userId;

  const LoginApiModel({
    required this.userId,
  });

  factory LoginApiModel.fromJson(Map<String, dynamic> json) {
    return _$LoginApiModelFromJson(json);
  }
}

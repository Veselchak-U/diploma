import 'package:json_annotation/json_annotation.dart';

part 'user_api_model.g.dart';

@JsonSerializable()
class UserApiModel {
  @JsonKey(includeToJson: false)
  final int iduser;
  final String name;
  final String surname;
  final String telephone;
  final String photo;

  UserApiModel({
    required this.iduser,
    required this.name,
    required this.surname,
    required this.telephone,
    required this.photo,
  });

  factory UserApiModel.fromJson(Map<String, dynamic> json) {
    return _$UserApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);
}

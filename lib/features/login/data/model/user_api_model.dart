import 'package:json_annotation/json_annotation.dart';

part 'user_api_model.g.dart';

@JsonSerializable()
class UserApiModel {
  @JsonKey(name: 'iduser', includeToJson: false)
  final int? id;
  final String name;
  final String surname;
  final String email;
  final String telephone;
  final String photo;

  UserApiModel({
    this.id,
    required this.name,
    required this.surname,
    required this.email,
    required this.telephone,
    required this.photo,
  });

  factory UserApiModel.fromJson(Map<String, dynamic> json) {
    return _$UserApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);

  bool get isComplete =>
      name.trim().isNotEmpty &&
      email.trim().isNotEmpty &&
      telephone.trim().isNotEmpty &&
      photo.trim().isNotEmpty;

  UserApiModel copyWith({
    int? id,
    String? name,
    String? surname,
    String? telephone,
    String? photo,
  }) {
    return UserApiModel(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email,
      telephone: telephone ?? this.telephone,
      photo: photo ?? this.photo,
    );
  }
}

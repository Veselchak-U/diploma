import 'package:get_pet/app/utils/date_time_ext.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_api_model.g.dart';

@JsonSerializable(
  createToJson: false,
  fieldRename: FieldRename.none,
)
class UserApiModel {
  final int? id;
  @ConvertDateTime()
  final DateTime? expiresAt;
  @ConvertDateTime()
  @JsonKey(name: "deleted_at")
  final DateTime? deletedAt;
  final String? code;
  final bool? active;

  UserApiModel({
    this.id,
    this.expiresAt,
    this.deletedAt,
    this.code,
    this.active,
  });

  factory UserApiModel.fromJson(Map<String, dynamic> json) {
    return _$UserApiModelFromJson(json);
  }

  bool get isDeleted => deletedAt != null;

  bool get isExpired => expiresAt?.isBeforeToday() == true;

  bool get isInactive => active == false;

  bool get isActive => !isInactive && !isExpired;

  bool get hasCodeChanged => code != null;
}

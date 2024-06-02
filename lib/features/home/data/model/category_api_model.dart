import 'dart:typed_data';

import 'package:get_pet/app/utils/string_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_api_model.g.dart';

@JsonSerializable()
class CategoryApiModel {
  @JsonKey(name: 'idcategory')
  final int id;
  final String name;
  @JsonKey(
    fromJson: StringUtils.base64ToUint8List,
    toJson: StringUtils.uint8ListToBase64,
  )
  final Uint8List photo;
  final int? count;

  const CategoryApiModel({
    required this.id,
    required this.name,
    required this.photo,
    required this.count,
  });

  factory CategoryApiModel.fromJson(Map<String, dynamic> json) {
    return _$CategoryApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategoryApiModelToJson(this);

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other.runtimeType != runtimeType) return false;

    return other is CategoryApiModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

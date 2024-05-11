import 'package:json_annotation/json_annotation.dart';

part 'category_api_model.g.dart';

@JsonSerializable()
class CategoryApiModel {
  @JsonKey(name: 'idcategory')
  final int id;
  final String name;
  final String photo;
  final int count;

  CategoryApiModel({
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
}

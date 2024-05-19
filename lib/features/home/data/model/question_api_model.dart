import 'package:json_annotation/json_annotation.dart';

part 'question_api_model.g.dart';

@JsonSerializable()
class QuestionApiModel {
  @JsonKey(name: 'idquestions')
  final int? id;
  @JsonKey(name: 'user_iduser')
  final int? idUser;
  final String title;
  final String description;
  final String? photo;
  final String? answer;

  const QuestionApiModel({
    required this.id,
    required this.idUser,
    required this.title,
    required this.description,
    required this.photo,
    required this.answer,
  });

  factory QuestionApiModel.fromJson(Map<String, dynamic> json) {
    return _$QuestionApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$QuestionApiModelToJson(this);
}

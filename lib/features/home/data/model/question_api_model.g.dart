// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionApiModel _$QuestionApiModelFromJson(Map<String, dynamic> json) =>
    QuestionApiModel(
      id: json['idquestions'] as int?,
      idUser: json['user_iduser'] as int?,
      title: json['title'] as String,
      description: json['description'] as String,
      photo: json['photo'] as String?,
      answer: json['answer'] as String?,
    );

Map<String, dynamic> _$QuestionApiModelToJson(QuestionApiModel instance) =>
    <String, dynamic>{
      'idquestions': instance.id,
      'user_iduser': instance.idUser,
      'title': instance.title,
      'description': instance.description,
      'photo': instance.photo,
      'answer': instance.answer,
    };

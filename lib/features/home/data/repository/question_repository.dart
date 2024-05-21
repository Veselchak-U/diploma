import 'package:get_pet/app/service/logger/exception/logic_exception.dart';
import 'package:get_pet/app/service/storage/local_storage.dart';
import 'package:get_pet/features/home/data/datasource/questions_datasource.dart';
import 'package:get_pet/features/home/data/model/question_api_model.dart';
import 'package:get_pet/features/home/domain/entity/question_entity.dart';

abstract interface class QuestionRepository {
  Future<List<QuestionEntity>> getUserQuestions();

  Future<void> addQuestion(QuestionEntity question);

  Future<void> markAsRead(QuestionEntity question);
}

class QuestionRepositoryImpl implements QuestionRepository {
  final QuestionDatasource _questionDatasource;
  final LocalStorage _localStorage;

  QuestionRepositoryImpl(
    this._questionDatasource,
    this._localStorage,
  );

  @override
  Future<List<QuestionEntity>> getUserQuestions() async {
    final userId = await _localStorage.getUserId();
    if (userId == null) {
      return [];
    }

    final models = await _questionDatasource.getUserQuestions(userId);
    final readIds = _localStorage.getReadQuestionIds();
    final entities = models.map((e) => _convertToEntity(e, readIds)).toList();

    return entities;
  }

  @override
  Future<void> addQuestion(QuestionEntity entity) {
    final model = _convertToModel(entity);

    return _questionDatasource.addQuestion(model);
  }

  @override
  Future<void> markAsRead(QuestionEntity question) async {
    final questionId = question.id;
    if (questionId == null) {
      throw const LogicException('Cannot mark as read question with null id');
    }

    final readIds = _localStorage.getReadQuestionIds();
    readIds.add(questionId);
    await _localStorage.setReadQuestionIds(readIds);
  }

  QuestionEntity _convertToEntity(
    QuestionApiModel model,
    Set<int> readIds,
  ) {
    final isRead = readIds.contains(model.id);

    return QuestionEntity(
      isNew: model.answer != null && !isRead,
      id: model.id,
      userId: model.userId,
      title: model.title,
      description: model.description,
      photo: model.photo,
      answer: model.answer,
    );
  }

  QuestionApiModel _convertToModel(QuestionEntity entity) {
    return QuestionApiModel(
      id: entity.id,
      userId: entity.userId,
      title: entity.title,
      description: entity.description,
      photo: entity.photo,
      answer: entity.answer,
    );
  }
}

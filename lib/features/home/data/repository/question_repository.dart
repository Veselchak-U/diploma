import 'package:get_pet/app/service/storage/local_storage.dart';
import 'package:get_pet/features/home/data/datasource/questions_datasource.dart';
import 'package:get_pet/features/home/data/model/question_api_model.dart';

abstract interface class QuestionRepository {
  Future<List<QuestionApiModel>> getUserQuestions();
}

class QuestionRepositoryImpl implements QuestionRepository {
  final QuestionDatasource _questionDatasource;
  final LocalStorage _localStorage;

  QuestionRepositoryImpl(
    this._questionDatasource,
    this._localStorage,
  );

  @override
  Future<List<QuestionApiModel>> getUserQuestions() async {
    final userId = await _localStorage.getUserId();
    if (userId == null) {
      return [];
    }

    return _questionDatasource.getUserQuestions(userId);
  }
}

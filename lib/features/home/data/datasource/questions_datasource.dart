import 'package:get_pet/app/service/storage/remote_storage.dart';
import 'package:get_pet/features/home/data/model/question_api_model.dart';

abstract interface class QuestionDatasource {
  Future<List<QuestionApiModel>> getUserQuestions(int userId);

  Future<void> addQuestion(QuestionApiModel question);
}

class QuestionDatasourceImpl implements QuestionDatasource {
  final RemoteStorage _remoteStorage;

  const QuestionDatasourceImpl(this._remoteStorage);

  @override
  Future<List<QuestionApiModel>> getUserQuestions(int userId) async {
    final result = await _remoteStorage.select(
      from: 'questions',
      where: {'user_iduser': userId},
    );

    return result.isEmpty
        ? []
        : result.map((e) => QuestionApiModel.fromJson(e)).toList();
  }

  @override
  Future<void> addQuestion(QuestionApiModel question) {
    return _remoteStorage.insert(
      to: 'questions',
      data: question.toJson(),
    );
  }
}

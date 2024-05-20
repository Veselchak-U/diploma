import 'dart:async';
import 'dart:io';

import 'package:control/control.dart';
import 'package:get_pet/app/service/storage/local_storage.dart';
import 'package:get_pet/app/service/storage/remote_file_storage.dart';
import 'package:get_pet/features/home/data/model/question_api_model.dart';
import 'package:get_pet/features/home/data/repository/question_repository.dart';

part 'support_controller_state.dart';

final class SupportController extends StateController<SupportControllerState>
    with SequentialControllerHandler {
  final QuestionRepository _questionRepository;
  final RemoteFileStorage _remoteFileStorage;
  final LocalStorage _localStorage;

  SupportController(
    this._questionRepository,
    this._remoteFileStorage,
    this._localStorage, {
    super.initialState = const SupportController$Idle(),
  }) {
    _init();
  }

  void _init() {}

  @override
  void dispose() {
    super.dispose();
  }

  void getUserQuestions() {
    return handle(
      () async {
        setState(const SupportController$Loading());
        final questions = await _questionRepository.getUserQuestions();
        setState(SupportController$QuestionsSuccess(questions));
      },
      _errorHandler,
      _doneHandler,
    );
  }

  void uploadImage(File file) {
    return handle(
      () async {
        setState(const SupportController$ImageLoading());
        final imageUrl = await _remoteFileStorage.uploadUserImage(file);
        setState(SupportController$ImageSuccess(imageUrl));
      },
      _errorHandler,
      _doneHandler,
    );
  }

  void addQuestion({
    required String title,
    required String description,
    String? imageUrl,
  }) {
    return handle(
      () async {
        setState(const SupportController$Loading());

        final userId = await _localStorage.getUserId();
        final question = QuestionApiModel(
          id: null,
          idUser: userId,
          title: title,
          description: description,
          photo: imageUrl,
          answer: null,
        );

        await _questionRepository.addQuestion(question);
        setState(const SupportController$AddSuccess());
      },
      _errorHandler,
      _doneHandler,
    );
  }

  FutureOr<void> _errorHandler(Object e, StackTrace st) {
    setState(SupportController$Error(e));
  }

  FutureOr<void> _doneHandler() {
    setState(const SupportController$Idle());
  }
}

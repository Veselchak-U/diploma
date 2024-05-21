import 'dart:async';
import 'dart:io';

import 'package:control/control.dart';
import 'package:get_pet/app/service/logger/logger_service.dart';
import 'package:get_pet/app/service/storage/local_storage.dart';
import 'package:get_pet/app/service/storage/remote_file_storage.dart';
import 'package:get_pet/features/home/data/repository/question_repository.dart';
import 'package:get_pet/features/home/domain/entity/question_entity.dart';

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

  Timer? _questionsUpdateTimer;

  void _init() {
    _startUpdateTimer();
  }

  @override
  void dispose() {
    _questionsUpdateTimer?.cancel();
    super.dispose();
  }

  void _startUpdateTimer() {
    _questionsUpdateTimer = Timer(
      const Duration(seconds: 30),
      () {
        LoggerService().d('SupportController._questionsUpdateTimer fired');
        getUserQuestions();
        _startUpdateTimer();
      },
    );
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
        final question = QuestionEntity(
          isNew: false,
          id: null,
          userId: userId,
          title: title,
          description: description,
          photo: imageUrl,
          answer: null,
        );

        await _questionRepository.addQuestion(question);
        setState(const SupportController$AddSuccess());

        // Update list after adding
        getUserQuestions();
      },
      _errorHandler,
      _doneHandler,
    );
  }

  void markAsRead(QuestionEntity question) {
    return handle(
      () async {
        await _questionRepository.markAsRead(question);
        // Update list after
        getUserQuestions();
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

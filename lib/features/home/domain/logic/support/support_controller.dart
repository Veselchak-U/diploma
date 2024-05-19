import 'dart:async';

import 'package:control/control.dart';
import 'package:get_pet/features/home/data/model/question_api_model.dart';
import 'package:get_pet/features/home/data/repository/question_repository.dart';

part 'support_controller_state.dart';

final class SupportController extends StateController<SupportControllerState>
    with SequentialControllerHandler {
  final QuestionRepository _questionRepository;

  SupportController(
    this._questionRepository, {
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

  FutureOr<void> _errorHandler(Object e, StackTrace st) {
    setState(SupportController$Error(e));
  }

  FutureOr<void> _doneHandler() {
    setState(const SupportController$Idle());
  }
}

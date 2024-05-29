import 'package:flutter/material.dart';
import 'package:get_pet/app/navigation/app_route.dart';
import 'package:get_pet/features/home/domain/entity/question_entity.dart';
import 'package:get_pet/features/home/domain/logic/support/support_controller.dart';
import 'package:get_pet/widgets/app_overlays.dart';
import 'package:go_router/go_router.dart';

class SupportPageVm {
  final BuildContext _context;
  final SupportController _supportController;

  SupportPageVm(
    this._context,
    this._supportController,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final questions = ValueNotifier<List<QuestionEntity>>([]);

  Future<void> _init() async {
    _supportController.addListener(_supportControllerListener);
    _supportController.getUserQuestions();
  }

  void dispose() {
    _supportController.removeListener(_supportControllerListener);
    loading.dispose();
    questions.dispose();
  }

  void updateQuestions() {
    _supportController.getUserQuestions();
  }

  Future<void> addNewQuestion() async {
    GoRouter.of(_context).pushNamed(
      AppRoute.questionAdd.name,
    );
  }

  Future<void> openQuestionDetails(QuestionEntity question) async {
    if (question.isNew) {
      _supportController.markAsRead(question);
    }

    GoRouter.of(_context).pushNamed(
      AppRoute.questionDetails.name,
      extra: question,
    );
  }

  void _supportControllerListener() {
    final state = _supportController.state;
    _handleLoading(state);
    _handleUpdate(state);
    _handleError(state);
  }

  void _handleLoading(SupportControllerState state) {
    loading.value = switch (state) {
      const SupportController$Loading() => true,
      _ => false,
    };
  }

  void _handleUpdate(SupportControllerState state) {
    switch (state) {
      case SupportController$QuestionsSuccess():
        questions.value = state.questions;
        break;
      default:
        break;
    }
  }

  void _handleError(SupportControllerState state) {
    switch (state) {
      case SupportController$Error():
        AppOverlays.showErrorBanner(msg: '${state.error}');
        break;
      default:
        break;
    }
  }
}

part of 'support_controller.dart';

sealed class SupportControllerState {
  const SupportControllerState();
}

final class SupportController$Idle extends SupportControllerState {
  const SupportController$Idle();
}

final class SupportController$Loading extends SupportControllerState {
  const SupportController$Loading();
}

final class SupportController$QuestionsSuccess extends SupportControllerState {
  final List<QuestionApiModel> questions;

  const SupportController$QuestionsSuccess(this.questions);
}

final class SupportController$Error extends SupportControllerState {
  final Object error;

  const SupportController$Error(this.error);
}

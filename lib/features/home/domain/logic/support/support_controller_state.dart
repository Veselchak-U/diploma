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
  final List<QuestionEntity> questions;

  const SupportController$QuestionsSuccess(this.questions);
}

final class SupportController$ImageLoading extends SupportControllerState {
  const SupportController$ImageLoading();
}

final class SupportController$ImageSuccess extends SupportControllerState {
  final String imageUrl;

  const SupportController$ImageSuccess(this.imageUrl);
}

final class SupportController$AddSuccess extends SupportControllerState {
  const SupportController$AddSuccess();
}

final class SupportController$Error extends SupportControllerState {
  final Object error;

  const SupportController$Error(this.error);
}

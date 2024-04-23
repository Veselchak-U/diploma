part of 'lifecycle_controller.dart';

sealed class LifecycleControllerState {
  const LifecycleControllerState();
}

final class LifecycleController$Idle extends LifecycleControllerState {
  const LifecycleController$Idle();
}

final class LifecycleController$Changed extends LifecycleControllerState {
  final AppLifecycleState state;

  const LifecycleController$Changed(this.state);
}

final class LifecycleController$Error extends LifecycleControllerState {
  final Object error;

  const LifecycleController$Error(this.error);
}

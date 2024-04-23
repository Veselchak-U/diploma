part of 'login_controller.dart';

sealed class LoginControllerState {
  const LoginControllerState();
}

final class LoginController$Idle extends LoginControllerState {
  const LoginController$Idle();
}

final class LoginController$Loading extends LoginControllerState {
  const LoginController$Loading();
}

final class LoginController$UserInactive extends LoginControllerState {
  final String reason;

  const LoginController$UserInactive(this.reason);
}

final class LoginController$Success extends LoginControllerState {
  const LoginController$Success();
}

final class LoginController$Error extends LoginControllerState {
  final Object error;

  const LoginController$Error(this.error);
}

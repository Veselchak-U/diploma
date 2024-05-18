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

final class LoginController$LoginSuccess extends LoginControllerState {
  final UserApiModel user;

  const LoginController$LoginSuccess(this.user);
}

final class LoginController$ImageLoading extends LoginControllerState {
  const LoginController$ImageLoading();
}

final class LoginControllerS$ImageSuccess extends LoginControllerState {
  final String imageUrl;

  const LoginControllerS$ImageSuccess(this.imageUrl);
}

final class LoginController$UserUpdated extends LoginControllerState {
  const LoginController$UserUpdated();
}

final class LoginController$Error extends LoginControllerState {
  final Object error;

  const LoginController$Error(this.error);
}

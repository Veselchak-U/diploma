part of 'user_controller.dart';

sealed class UserControllerState {
  const UserControllerState();
}

final class UserController$Idle extends UserControllerState {
  const UserController$Idle();
}

final class UserController$Loading extends UserControllerState {
  const UserController$Loading();
}

final class UserController$UserInactive extends UserControllerState {
  final String reason;

  const UserController$UserInactive(this.reason);
}

final class UserController$LoginSuccess extends UserControllerState {
  final UserApiModel user;

  const UserController$LoginSuccess(this.user);
}

final class UserController$ImageLoading extends UserControllerState {
  const UserController$ImageLoading();
}

final class UserControllerS$ImageSuccess extends UserControllerState {
  final String imageUrl;

  const UserControllerS$ImageSuccess(this.imageUrl);
}

final class UserController$UserUpdated extends UserControllerState {
  final UserApiModel user;

  const UserController$UserUpdated(this.user);
}

final class UserController$Error extends UserControllerState {
  final Object error;

  const UserController$Error(this.error);
}

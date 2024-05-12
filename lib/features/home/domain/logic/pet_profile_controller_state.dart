part of 'pet_profile_controller.dart';

sealed class PetProfileControllerState {
  const PetProfileControllerState();
}

final class PetProfileController$Idle extends PetProfileControllerState {
  const PetProfileController$Idle();
}

final class PetProfileController$Loading extends PetProfileControllerState {
  const PetProfileController$Loading();
}

final class PetProfileController$CategoriesSuccess
    extends PetProfileControllerState {
  final List<CategoryApiModel> categories;

  const PetProfileController$CategoriesSuccess(this.categories);
}

final class PetProfileController$AddSuccess extends PetProfileControllerState {
  const PetProfileController$AddSuccess();
}

final class PetProfileController$UpdateSuccess
    extends PetProfileControllerState {
  const PetProfileController$UpdateSuccess();
}

final class PetProfileController$Error extends PetProfileControllerState {
  final Object error;

  const PetProfileController$Error(this.error);
}

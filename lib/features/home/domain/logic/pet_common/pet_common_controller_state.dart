part of 'pet_common_controller.dart';

sealed class PetCommonControllerState {
  final List<CategoryApiModel> categories;

  const PetCommonControllerState(this.categories);
}

final class PetCommonController$Idle extends PetCommonControllerState {
  const PetCommonController$Idle(super.categories);
}

final class PetCommonController$Loading extends PetCommonControllerState {
  const PetCommonController$Loading(super.categories);
}

final class PetCommonController$CategoriesUpdated
    extends PetCommonControllerState {
  const PetCommonController$CategoriesUpdated(super.categories);
}

final class PetCommonController$NewPetsUpdated
    extends PetCommonControllerState {
  final List<PetEntity> newPets;

  const PetCommonController$NewPetsUpdated(super.categories, this.newPets);
}

final class PetCommonController$Error extends PetCommonControllerState {
  final Object error;

  const PetCommonController$Error(this.error, super.categories);
}

part of 'pet_details_controller.dart';

sealed class PetDetailsControllerState {
  const PetDetailsControllerState();
}

final class PetDetailsController$Idle extends PetDetailsControllerState {
  const PetDetailsController$Idle();
}

final class PetDetailsController$Loading extends PetDetailsControllerState {
  const PetDetailsController$Loading();
}

final class PetDetailsController$UserSuccess extends PetDetailsControllerState {
  final UserApiModel user;
  final bool isMyPet;

  const PetDetailsController$UserSuccess(this.user, this.isMyPet);
}

final class PetDetailsController$DeletePetSuccess
    extends PetDetailsControllerState {
  const PetDetailsController$DeletePetSuccess();
}

final class PetDetailsController$Error extends PetDetailsControllerState {
  final Object error;

  const PetDetailsController$Error(this.error);
}

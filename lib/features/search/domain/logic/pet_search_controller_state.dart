part of 'pet_search_controller.dart';

sealed class PetSearchControllerState {
  const PetSearchControllerState();
}

final class PetSearchController$Idle extends PetSearchControllerState {
  const PetSearchController$Idle();
}

final class PetSearchController$Loading extends PetSearchControllerState {
  const PetSearchController$Loading();
}

final class PetSearchController$CategoriesSuccess extends PetSearchControllerState {
  final List<CategoryApiModel> categories;

  const PetSearchController$CategoriesSuccess(this.categories);
}

final class PetSearchController$SearchSuccess extends PetSearchControllerState {
  final List<PetEntity> foundedPets;

  const PetSearchController$SearchSuccess(this.foundedPets);
}

final class PetSearchController$SearchOutside extends PetSearchControllerState {
  final SearchFilter searchFilter;

  const PetSearchController$SearchOutside(this.searchFilter);
}

final class PetSearchController$Error extends PetSearchControllerState {
  final Object error;

  const PetSearchController$Error(this.error);
}

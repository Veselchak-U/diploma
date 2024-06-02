import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/domain/entity/pet_type.dart';

class SearchFilter {
  final List<CategoryApiModel> selectedCategories;
  final List<PetType> selectedTypes;
  final String searchText;

  SearchFilter({
    this.selectedCategories = const [],
    this.selectedTypes = const [],
    this.searchText = '',
  });

  bool get isEmpty =>
      selectedCategories.isEmpty &&
      selectedTypes.isEmpty &&
      searchText.trim().isEmpty;

  SearchFilter copyWith({
    String? searchText,
  }) {
    return SearchFilter(
      selectedCategories: selectedCategories,
      selectedTypes: selectedTypes,
      searchText: searchText ?? this.searchText,
    );
  }
}

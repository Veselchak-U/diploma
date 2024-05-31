import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/domain/entity/pet_type.dart';

class SearchFilter {
  final List<CategoryApiModel> selectedCategories;
  final List<PetType> selectedTypes;
  final String searchText;

  SearchFilter({
    required this.selectedCategories,
    required this.selectedTypes,
    required this.searchText,
  });
}

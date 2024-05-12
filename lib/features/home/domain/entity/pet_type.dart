enum PetType {
  adopting,
  mating,
  sale,
}

class PetTypeHelper {
  static String toLabel(PetType type) => switch (type) {
        PetType.adopting => 'Отдам в хорошие руки',
        PetType.mating => 'Ищу пару',
        PetType.sale => 'Продажа',
      };
}

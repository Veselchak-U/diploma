enum PetType {
  adopting,
  mating,
  sale;

  @override
  String toString() => switch (this) {
        PetType.adopting => 'Отдам в хорошие руки',
        PetType.mating => 'Ищу пару',
        PetType.sale => 'Продажа',
      };
}

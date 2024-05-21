class QuestionEntity {
  final bool isNew;
  final int? id;
  final int? userId;
  final String title;
  final String description;
  final String? photo;
  final String? answer;

  QuestionEntity({
    required this.isNew,
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.photo,
    required this.answer,
  });

  QuestionEntity copyWith({
    bool? isNew,
  }) {
    return QuestionEntity(
      isNew: isNew ?? this.isNew,
      id: id,
      userId: userId,
      title: title,
      description: description,
      photo: photo,
      answer: answer,
    );
  }
}

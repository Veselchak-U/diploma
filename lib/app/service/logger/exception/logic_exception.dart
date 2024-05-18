class LogicException implements Exception {
  final String message;

  const LogicException(this.message);

  @override
  String toString() => message;
}

extension IntegerExt on int {
  String toMb() => '${(this / 1024 / 1024).toStringAsFixed(1)}Mb';
}

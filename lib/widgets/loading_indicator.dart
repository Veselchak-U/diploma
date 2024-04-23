import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final Color? color;

  const LoadingIndicator({this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: 2,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get_pet/widgets/loading_indicator.dart';

enum LoadingButtonType { primary, transparent }

class LoadingButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final LoadingButtonType type;

  const LoadingButton({
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.type = LoadingButtonType.primary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final button = switch (type) {
      LoadingButtonType.primary => ElevatedButton(
          onPressed: loading ? null : onPressed,
          child: Text(label),
        ),
      LoadingButtonType.transparent => TextButton(
          onPressed: loading ? null : onPressed,
          child: Text(label),
        ),
    };

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child: button,
        ),
        loading ? const LoadingIndicator() : const SizedBox.shrink(),
      ],
    );
  }
}

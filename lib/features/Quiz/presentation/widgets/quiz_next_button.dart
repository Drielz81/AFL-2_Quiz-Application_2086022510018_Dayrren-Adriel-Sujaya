import 'package:flutter/material.dart';

class QuizNextButton extends StatelessWidget {
  const QuizNextButton({
    super.key,
    required this.isLast,
    required this.enabled,
    required this.onPressed,
  });

  final bool isLast;
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: enabled ? onPressed : null,
      icon: Icon(isLast ? Icons.flag_rounded : Icons.arrow_forward_rounded),
      label: Text(isLast ? 'Lihat Hasil' : 'Lanjut'),
    );
  }
}

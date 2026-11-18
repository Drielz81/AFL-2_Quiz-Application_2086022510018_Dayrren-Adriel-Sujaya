import 'package:flutter/material.dart';

/// Background halaman kuis: gradien hangat tipis dari seed.
class QuizBackground extends StatelessWidget {
  const QuizBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final s = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.alphaBlend(s.primaryContainer.withValues(alpha: 0.55), s.surface),
            s.surface,
            Color.alphaBlend(s.tertiaryContainer.withValues(alpha: 0.35), s.surface),
          ],
        ),
      ),
      child: SizedBox.expand(child: child),
    );
  }
}

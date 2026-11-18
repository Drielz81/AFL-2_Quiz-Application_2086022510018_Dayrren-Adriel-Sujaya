import 'package:flutter/material.dart';

/// Kartu utama pembungkus kuis: gradien warm + outline tipis warna seed.
class QuizCardContainer extends StatelessWidget {
  const QuizCardContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final s = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: s.primary.withValues(alpha: 0.35), width: 1),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.alphaBlend(s.primaryContainer.withValues(alpha: 0.55), s.surface),
            Color.alphaBlend(s.tertiaryContainer.withValues(alpha: 0.45), s.surface),
          ],
        ),
      ),
      child: child,
    );
  }
}

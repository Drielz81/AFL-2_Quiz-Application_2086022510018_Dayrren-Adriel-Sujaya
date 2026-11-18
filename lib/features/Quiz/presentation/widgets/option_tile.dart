import 'package:flutter/material.dart';
import 'package:afl2/core/theme/quiz_colors.dart';

enum OptionStatus { idle, correct, wrong, revealedCorrect, locked }

class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.index,
    required this.label,
    required this.status,
    this.onTap,
  });

  final int index;
  final String label;
  final OptionStatus status;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final quiz = theme.extension<QuizColors>()!;

    final (Color bg, Color border, double borderWidth, Color fg) = switch (status) {
      OptionStatus.idle => (
          scheme.surface.withValues(alpha: 0.75),
          scheme.outlineVariant,
          1.0,
          scheme.onSurface,
        ),
      OptionStatus.correct => (
          quiz.correctContainer,
          quiz.correct,
          2.0,
          quiz.onCorrectContainer,
        ),
      OptionStatus.wrong => (
          scheme.errorContainer,
          scheme.error,
          2.0,
          scheme.onErrorContainer,
        ),
      OptionStatus.revealedCorrect => (
          quiz.correctContainer.withValues(alpha: 0.5),
          quiz.correct.withValues(alpha: 0.55),
          1.5,
          scheme.onSurface,
        ),
      OptionStatus.locked => (
          scheme.surface.withValues(alpha: 0.4),
          scheme.outlineVariant.withValues(alpha: 0.5),
          1.0,
          scheme.onSurface.withValues(alpha: 0.55),
        ),
    };

    final radius = BorderRadius.circular(16);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: radius,
        border: Border.all(color: border, width: borderWidth),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Row(
              children: [
                _leading(scheme, quiz, fg),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: fg,
                      height: 1.3,
                      fontWeight: status == OptionStatus.correct ||
                              status == OptionStatus.wrong
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _leading(ColorScheme scheme, QuizColors quiz, Color fg) {
    switch (status) {
      case OptionStatus.correct:
        return Icon(Icons.check_circle_rounded, color: quiz.correct, size: 28);
      case OptionStatus.wrong:
        return Icon(Icons.cancel_rounded, color: scheme.error, size: 28);
      case OptionStatus.revealedCorrect:
        return Icon(
          Icons.check_circle_outline_rounded,
          color: quiz.correct.withValues(alpha: 0.75),
          size: 28,
        );
      case OptionStatus.idle:
      case OptionStatus.locked:
        return Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: fg.withValues(alpha: 0.6), width: 1.2),
          ),
          child: Text(
            String.fromCharCode(65 + index),
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: fg),
          ),
        );
    }
  }
}

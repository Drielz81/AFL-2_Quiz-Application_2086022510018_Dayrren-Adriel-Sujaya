import 'package:flutter/material.dart';

/// Warna semantik "benar" (Material 3 tidak punya warna success bawaan).
/// Didefinisikan sekali di theme; widget tidak boleh hardcode warna.
@immutable
class QuizColors extends ThemeExtension<QuizColors> {
  const QuizColors({
    required this.correct,
    required this.correctContainer,
    required this.onCorrectContainer,
  });

  final Color correct;
  final Color correctContainer;
  final Color onCorrectContainer;

  static const light = QuizColors(
    correct: Color(0xFF2E7D4F),
    correctContainer: Color(0xFFD3EBD9),
    onCorrectContainer: Color(0xFF0B3A1D),
  );

  static const dark = QuizColors(
    correct: Color(0xFF7CCB97),
    correctContainer: Color(0xFF1F4A31),
    onCorrectContainer: Color(0xFFD3EBD9),
  );

  @override
  QuizColors copyWith({
    Color? correct,
    Color? correctContainer,
    Color? onCorrectContainer,
  }) {
    return QuizColors(
      correct: correct ?? this.correct,
      correctContainer: correctContainer ?? this.correctContainer,
      onCorrectContainer: onCorrectContainer ?? this.onCorrectContainer,
    );
  }

  @override
  QuizColors lerp(ThemeExtension<QuizColors>? other, double t) {
    if (other is! QuizColors) return this;
    return QuizColors(
      correct: Color.lerp(correct, other.correct, t)!,
      correctContainer: Color.lerp(correctContainer, other.correctContainer, t)!,
      onCorrectContainer:
          Color.lerp(onCorrectContainer, other.onCorrectContainer, t)!,
    );
  }
}

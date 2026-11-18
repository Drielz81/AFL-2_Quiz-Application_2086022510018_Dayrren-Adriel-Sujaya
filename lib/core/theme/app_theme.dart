import 'package:flutter/material.dart';
import 'package:afl2/core/theme/quiz_colors.dart';

/// Tema "paper & ink": seed sepia/tinta, permukaan krem kertas (light)
/// dan tinta gelap hangat (dark).
class AppTheme {
  const AppTheme._();

  static const Color _seed = Color(0xFF8B5E3C);

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    final base = ColorScheme.fromSeed(seedColor: _seed, brightness: brightness);

    final scheme = isLight
        ? base.copyWith(
            surface: const Color(0xFFF7F0E1),
            onSurface: const Color(0xFF2B211A),
          )
        : base.copyWith(
            surface: const Color(0xFF1E1813),
            onSurface: const Color(0xFFEFE4D2),
          );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      extensions: [isLight ? QuizColors.light : QuizColors.dark],
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}

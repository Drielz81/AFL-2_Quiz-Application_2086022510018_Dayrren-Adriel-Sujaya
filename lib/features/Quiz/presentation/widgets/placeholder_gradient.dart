import 'package:flutter/material.dart';

/// Gradien placeholder dari theme, dipakai sebelum gambar asli tersedia.
class PlaceholderGradient {
  const PlaceholderGradient._();

  static List<Color> colors(ColorScheme s, int tone) {
    return switch (tone % 5) {
      0 => [s.primary, s.tertiary],
      1 => [s.tertiary, s.primary],
      2 => [s.secondary, s.tertiary],
      3 => [s.primary, s.secondary],
      _ => [s.tertiary, s.secondary],
    };
  }

  static LinearGradient of(ColorScheme s, int tone) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors(s, tone),
      );
}

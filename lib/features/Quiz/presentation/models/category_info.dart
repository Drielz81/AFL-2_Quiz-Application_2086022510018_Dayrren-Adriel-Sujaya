import 'package:flutter/material.dart';
import 'package:afl2/features/Quiz/domain/entities/quiz_category.dart';

enum CategoryGroup {
  sains('Sains'),
  umum('Umum'),
  keuangan('Keuangan');

  const CategoryGroup(this.label);
  final String label;
}

/// Metadata tampilan kategori (presentation only).
/// Isi [imageAsset] nanti untuk mengganti placeholder gradien.
class CategoryInfo {
  const CategoryInfo({
    required this.category,
    required this.label,
    required this.icon,
    required this.group,
    required this.tone,
    this.keywords = const [],
    this.questionCount = 10,
    this.estimatedMinutes = 5,
    this.imageAsset,
  });

  final QuizCategory category;
  final String label;
  final IconData icon;
  final CategoryGroup group;
  final int tone; // indeks variasi warna placeholder
  final List<String> keywords;
  final int questionCount;
  final int estimatedMinutes;
  final String? imageAsset;

  bool matches(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return true;
    return label.toLowerCase().contains(q) ||
        group.label.toLowerCase().contains(q) ||
        keywords.any((k) => k.toLowerCase().contains(q));
  }

  static const all = <CategoryInfo>[
    CategoryInfo(
      category: QuizCategory.general,
      label: 'Umum',
      icon: Icons.public_rounded,
      group: CategoryGroup.umum,
      tone: 0,
      keywords: ['general', 'pengetahuan'],
    ),
    CategoryInfo(
      category: QuizCategory.biology,
      label: 'Biologi',
      icon: Icons.biotech_rounded,
      group: CategoryGroup.sains,
      tone: 1,
      keywords: ['biology', 'sel', 'makhluk hidup'],
    ),
    CategoryInfo(
      category: QuizCategory.mathematics,
      label: 'Matematika',
      icon: Icons.calculate_rounded,
      group: CategoryGroup.sains,
      tone: 2,
      keywords: ['mathematics', 'math', 'hitung'],
    ),
    CategoryInfo(
      category: QuizCategory.physics,
      label: 'Fisika',
      icon: Icons.bolt_rounded,
      group: CategoryGroup.sains,
      tone: 3,
      keywords: ['physics', 'gaya', 'energi'],
    ),
    CategoryInfo(
      category: QuizCategory.finance,
      label: 'Keuangan',
      icon: Icons.account_balance_wallet_rounded,
      group: CategoryGroup.keuangan,
      tone: 4,
      keywords: ['finance', 'uang', 'investasi'],
    ),
  ];

  static CategoryInfo of(QuizCategory category) =>
      all.firstWhere((i) => i.category == category);
}

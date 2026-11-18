import 'package:flutter/material.dart';

class CategoryEmptyState extends StatelessWidget {
  const CategoryEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          Icon(Icons.search_off_rounded, size: 56, color: scheme.outline),
          const SizedBox(height: 12),
          Text('Kuis tidak ditemukan', style: text.titleMedium),
          const SizedBox(height: 4),
          Text(
            'Coba kata kunci atau kategori lain.',
            textAlign: TextAlign.center,
            style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

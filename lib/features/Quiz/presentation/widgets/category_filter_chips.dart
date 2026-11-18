import 'package:flutter/material.dart';
import 'package:afl2/features/Quiz/presentation/models/category_info.dart';

/// Chip kelompok kategori. [selected] null = "Semua".
class CategoryFilterChips extends StatelessWidget {
  const CategoryFilterChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final CategoryGroup? selected;
  final ValueChanged<CategoryGroup?> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ChoiceChip(
            label: const Text('Semua'),
            selected: selected == null,
            onSelected: (_) => onSelected(null),
          ),
          for (final group in CategoryGroup.values) ...[
            const SizedBox(width: 8),
            ChoiceChip(
              label: Text(group.label),
              selected: selected == group,
              onSelected: (_) => onSelected(group),
            ),
          ],
        ],
      ),
    );
  }
}

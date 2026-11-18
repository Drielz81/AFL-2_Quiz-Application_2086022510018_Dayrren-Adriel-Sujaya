import 'package:flutter/material.dart';

class CategorySearchBar extends StatelessWidget {
  const CategorySearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SearchBar(
      controller: controller,
      onChanged: onChanged,
      hintText: 'Cari nama atau kategori kuis',
      elevation: const WidgetStatePropertyAll(0),
      backgroundColor:
          WidgetStatePropertyAll(scheme.surfaceContainerHigh.withValues(alpha: 0.9)),
      side: WidgetStatePropertyAll(
        BorderSide(color: scheme.outlineVariant, width: 1),
      ),
      leading: const Icon(Icons.search_rounded),
      trailing: [
        if (controller.text.isNotEmpty)
          IconButton(
            tooltip: 'Hapus',
            icon: const Icon(Icons.close_rounded),
            onPressed: () {
              controller.clear();
              onChanged('');
            },
          ),
      ],
    );
  }
}

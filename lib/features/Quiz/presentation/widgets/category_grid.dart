import 'package:flutter/material.dart';
import 'package:afl2/features/Quiz/presentation/models/category_info.dart';
import 'package:afl2/features/Quiz/presentation/widgets/category_card.dart';

/// Grid responsif: <600px = 2 kolom, <900px = 3, selebihnya 4.
class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key, required this.items, required this.onSelected});

  final List<CategoryInfo> items;
  final ValueChanged<CategoryInfo> onSelected;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columns = width < 600 ? 2 : (width < 900 ? 3 : 4);
        final textScale =
            (MediaQuery.textScalerOf(context).scale(14) / 14).clamp(1.0, 1.6);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            mainAxisExtent: 210 * textScale.toDouble(),
          ),
          itemBuilder: (context, i) => CategoryCard(
            info: items[i],
            onTap: () => onSelected(items[i]),
          ),
        );
      },
    );
  }
}

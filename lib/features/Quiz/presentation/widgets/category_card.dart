import 'package:flutter/material.dart';
import 'package:afl2/features/Quiz/presentation/models/category_info.dart';
import 'package:afl2/features/Quiz/presentation/widgets/placeholder_gradient.dart';

/// Radius kartu. Turunkan bila terasa terlalu bulat di layar kecil.
const double kCategoryCardRadius = 56;

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.info, required this.onTap});

  final CategoryInfo info;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final radius = BorderRadius.circular(kCategoryCardRadius);

    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(color: scheme.outline.withValues(alpha: 0.45), width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _background(scheme),
            // Scrim bawah agar teks putih terbaca di gambar apa pun.
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x00000000), Color(0xCC000000)],
                  stops: [0.35, 1],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 22, 24, 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.22),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(info.icon, color: Colors.white, size: 22),
                  ),
                  const Spacer(),
                  Text(
                    info.label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: text.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 10,
                    runSpacing: 2,
                    children: [
                      _meta(text, Icons.help_outline_rounded,
                          '${info.questionCount} soal'),
                      _meta(text, Icons.schedule_rounded,
                          '± ${info.estimatedMinutes} menit'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _background(ColorScheme scheme) {
    final asset = info.imageAsset;
    if (asset != null) return Image.asset(asset, fit: BoxFit.cover);
    return DecoratedBox(
      decoration: BoxDecoration(gradient: PlaceholderGradient.of(scheme, info.tone)),
    );
  }

  Widget _meta(TextTheme text, IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: Colors.white70),
        const SizedBox(width: 4),
        Text(label, style: text.bodySmall?.copyWith(color: Colors.white70)),
      ],
    );
  }
}

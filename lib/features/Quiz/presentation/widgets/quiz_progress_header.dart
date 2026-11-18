import 'package:flutter/material.dart';

class QuizProgressHeader extends StatelessWidget {
  const QuizProgressHeader({
    super.key,
    required this.current,
    required this.total,
    required this.score,
    required this.answered,
  });

  final int current;
  final int total;
  final int score;
  final bool answered;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final progress = ((current - 1) + (answered ? 1 : 0)) / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Soal $current dari $total',
                style: text.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Icon(Icons.star_rounded, size: 18, color: scheme.primary),
            const SizedBox(width: 4),
            Text('Skor $score', style: text.titleSmall),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(end: progress),
            duration: const Duration(milliseconds: 300),
            builder: (context, value, _) =>
                LinearProgressIndicator(value: value, minHeight: 8),
          ),
        ),
      ],
    );
  }
}

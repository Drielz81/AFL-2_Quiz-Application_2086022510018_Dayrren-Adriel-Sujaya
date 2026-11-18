import 'package:flutter/material.dart';
import 'package:afl2/features/Quiz/presentation/widgets/quiz_card_container.dart';

class QuizResultView extends StatelessWidget {
  const QuizResultView({
    super.key,
    required this.score,
    required this.total,
    required this.onRetry,
    required this.onBack,
  });

  final int score;
  final int total;
  final VoidCallback onRetry;
  final VoidCallback onBack;

  double get _ratio => total == 0 ? 0 : score / total;
  int get _percent => (_ratio * 100).round();

  String get _message {
    if (_percent == 100) return 'Sempurna! Semua jawabanmu benar.';
    if (_percent >= 80) return 'Hebat! Pemahamanmu sangat baik.';
    if (_percent >= 60) return 'Bagus! Sedikit lagi menuju sempurna.';
    if (_percent >= 40) return 'Lumayan. Coba pelajari materinya lagi.';
    return 'Jangan menyerah, ulangi dan coba lagi.';
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: SingleChildScrollView(
        child: QuizCardContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Kuis Selesai',
                textAlign: TextAlign.center,
                style: text.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 24),
              Center(
                child: SizedBox(
                  width: 160,
                  height: 160,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(end: _ratio),
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, _) => Stack(
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(
                          value: value,
                          strokeWidth: 12,
                          strokeCap: StrokeCap.round,
                          backgroundColor: scheme.surfaceContainerHighest,
                        ),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '$score/$total',
                                style: text.headlineMedium
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                              Text('$_percent%', style: text.titleMedium),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                _message,
                textAlign: TextAlign.center,
                style: text.bodyLarge?.copyWith(height: 1.4),
              ),
              const SizedBox(height: 28),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.replay_rounded),
                label: const Text('Ulangi'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: onBack,
                icon: const Icon(Icons.home_rounded),
                label: const Text('Kembali ke beranda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

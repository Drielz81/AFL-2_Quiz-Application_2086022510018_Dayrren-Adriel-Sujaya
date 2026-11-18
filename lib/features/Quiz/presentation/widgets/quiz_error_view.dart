import 'package:flutter/material.dart';
import 'package:afl2/features/Quiz/presentation/widgets/quiz_card_container.dart';

class QuizErrorView extends StatelessWidget {
  const QuizErrorView({
    super.key,
    required this.message,
    required this.onRetry,
    required this.onBack,
  });

  final String message;
  final VoidCallback onRetry;
  final VoidCallback onBack;

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
              Icon(Icons.error_outline_rounded, size: 56, color: scheme.error),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: text.bodyLarge?.copyWith(height: 1.4),
              ),
              const SizedBox(height: 24),
              FilledButton(onPressed: onRetry, child: const Text('Coba lagi')),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: onBack,
                child: const Text('Kembali ke beranda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

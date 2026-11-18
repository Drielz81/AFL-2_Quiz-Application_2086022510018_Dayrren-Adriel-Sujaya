import 'package:flutter/material.dart';
import 'package:afl2/features/Quiz/presentation/widgets/quiz_exit_button.dart';

class QuizTopBar extends StatelessWidget {
  const QuizTopBar({super.key, required this.title, required this.needsConfirm});

  final String title;
  final bool needsConfirm;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Row(
      children: [
        QuizExitButton(needsConfirm: needsConfirm),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: text.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

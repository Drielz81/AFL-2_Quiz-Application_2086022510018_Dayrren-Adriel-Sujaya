import 'package:flutter/material.dart';
import 'package:afl2/features/Quiz/presentation/widgets/exit_confirm_dialog.dart';

class QuizExitButton extends StatelessWidget {
  const QuizExitButton({super.key, required this.needsConfirm});

  final bool needsConfirm;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => exitQuiz(context, needsConfirm: needsConfirm),
      icon: const Icon(Icons.close_rounded),
      label: const Text('Keluar'),
    );
  }
}

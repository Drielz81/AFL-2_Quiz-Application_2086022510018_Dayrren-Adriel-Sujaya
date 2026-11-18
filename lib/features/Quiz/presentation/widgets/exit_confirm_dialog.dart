import 'package:flutter/material.dart';

Future<bool> showExitConfirmDialog(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Keluar dari kuis?'),
      content: const Text('Progres kuis ini akan hilang.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(false),
          child: const Text('Lanjut mengerjakan'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
          onPressed: () => Navigator.of(ctx).pop(true),
          child: const Text('Keluar'),
        ),
      ],
    ),
  );
  return result ?? false;
}

/// Keluar langsung ke home; konfirmasi hanya bila [needsConfirm].
Future<void> exitQuiz(BuildContext context, {required bool needsConfirm}) async {
  if (needsConfirm) {
    final ok = await showExitConfirmDialog(context);
    if (!ok || !context.mounted) return;
  }
  Navigator.of(context).popUntil((route) => route.isFirst);
}

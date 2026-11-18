import 'package:flutter/material.dart';

/// Tanpa maxLines/ellipsis: teks soal wrap bebas dan tidak boleh terpotong.
class QuestionText extends StatelessWidget {
  const QuestionText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            height: 1.4,
          ),
    );
  }
}

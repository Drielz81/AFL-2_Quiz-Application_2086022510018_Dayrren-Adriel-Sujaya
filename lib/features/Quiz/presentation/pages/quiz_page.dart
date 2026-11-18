import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:afl2/features/Quiz/data/datasources/quiz_data_processor.dart';
import 'package:afl2/features/Quiz/data/repositories/quiz_repo_impl.dart';
import 'package:afl2/features/Quiz/domain/entities/quiz_category.dart';
import 'package:afl2/features/Quiz/presentation/cubit/quiz_cubit.dart';
import 'package:afl2/features/Quiz/presentation/widgets/quiz_view.dart';

/// DI manual: cubit dibuat di sini lewat BlocProvider.
class QuizPage extends StatelessWidget {
  const QuizPage({super.key, required this.category});

  final QuizCategory category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizCubit(QuizRepositoryImpl(QuizDataProcessor()))
        ..loadQuiz(category),
      child: QuizView(category: category),
    );
  }
}

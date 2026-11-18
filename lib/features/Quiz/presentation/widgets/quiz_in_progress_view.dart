import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:afl2/features/Quiz/presentation/cubit/quiz_cubit.dart';
import 'package:afl2/features/Quiz/presentation/cubit/quiz_state.dart';
import 'package:afl2/features/Quiz/presentation/widgets/options_list.dart';
import 'package:afl2/features/Quiz/presentation/widgets/question_text.dart';
import 'package:afl2/features/Quiz/presentation/widgets/quiz_card_container.dart';
import 'package:afl2/features/Quiz/presentation/widgets/quiz_next_button.dart';
import 'package:afl2/features/Quiz/presentation/widgets/quiz_progress_header.dart';

class QuizInProgressView extends StatelessWidget {
  const QuizInProgressView({super.key, required this.state});

  final QuizInProgress state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuizCubit>();
    final question = state.currentQuestion;

    return QuizCardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          QuizProgressHeader(
            current: state.currentIndex + 1,
            total: state.questions.length,
            score: state.score,
            answered: state.isAnswered,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              // key: scroll kembali ke atas tiap ganti soal
              key: ValueKey(state.currentIndex),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  QuestionText(text: question.text),
                  const SizedBox(height: 20),
                  const Divider(height: 1),
                  const SizedBox(height: 20),
                  OptionsList(
                    options: question.options,
                    correctIndex: question.correctOptionIndex,
                    selectedIndex: state.selectedIndex,
                    onSelect: cubit.selectAnswer,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          QuizNextButton(
            isLast: state.isLastQuestion,
            enabled: state.isAnswered,
            onPressed: cubit.nextQuestion,
          ),
        ],
      ),
    );
  }
}

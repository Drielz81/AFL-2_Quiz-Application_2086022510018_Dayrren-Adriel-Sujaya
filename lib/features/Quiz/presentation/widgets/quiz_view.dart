import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:afl2/features/Quiz/domain/entities/quiz_category.dart';
import 'package:afl2/features/Quiz/presentation/cubit/quiz_cubit.dart';
import 'package:afl2/features/Quiz/presentation/cubit/quiz_state.dart';
import 'package:afl2/features/Quiz/presentation/models/category_info.dart';
import 'package:afl2/features/Quiz/presentation/widgets/exit_confirm_dialog.dart';
import 'package:afl2/features/Quiz/presentation/widgets/quiz_background.dart';
import 'package:afl2/features/Quiz/presentation/widgets/quiz_error_view.dart';
import 'package:afl2/features/Quiz/presentation/widgets/quiz_in_progress_view.dart';
import 'package:afl2/features/Quiz/presentation/widgets/quiz_loading_view.dart';
import 'package:afl2/features/Quiz/presentation/widgets/quiz_result_view.dart';
import 'package:afl2/features/Quiz/presentation/widgets/quiz_top_bar.dart';

/// Memilih tampilan per state + PopScope (konfirmasi saat kuis berjalan).
class QuizView extends StatelessWidget {
  const QuizView({super.key, required this.category});

  final QuizCategory category;

  @override
  Widget build(BuildContext context) {
    final info = CategoryInfo.of(category);

    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
        final inProgress = state is QuizInProgress;

        return PopScope(
          canPop: !inProgress,
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) return;
            exitQuiz(context, needsConfirm: true);
          },
          child: Scaffold(
            body: QuizBackground(
              child: SafeArea(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 640),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: Column(
                        children: [
                          QuizTopBar(title: info.label, needsConfirm: inProgress),
                          const SizedBox(height: 8),
                          Expanded(child: _body(context, state)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _body(BuildContext context, QuizState state) {
    void goHome() => exitQuiz(context, needsConfirm: false);
    void reload() => context.read<QuizCubit>().loadQuiz(category);

    return switch (state) {
      QuizInitial() || QuizLoading() => const QuizLoadingView(),
      QuizInProgress() => QuizInProgressView(state: state),
      QuizFinished() => QuizResultView(
          score: state.score,
          total: state.total,
          onRetry: reload,
          onBack: goHome,
        ),
      QuizError() => QuizErrorView(
          message: state.message,
          onRetry: reload,
          onBack: goHome,
        ),
    };
  }
}

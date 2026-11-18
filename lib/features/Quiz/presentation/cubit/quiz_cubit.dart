import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:afl2/features/Quiz/domain/entities/quiz_category.dart';
import 'package:afl2/features/Quiz/domain/failure/quiz_load_fail.dart';
import 'package:afl2/features/Quiz/domain/repository/quiz_repository.dart';
import 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit(this._repository) : super(const QuizInitial());

  final QuizRepository _repository;

  Future<void> loadQuiz(QuizCategory category) async {
    emit(const QuizLoading());

    try {
      final questions = await _repository.getQuestions(category);
      if (isClosed) return;

      emit(QuizInProgress(
        questions: questions,
        currentIndex: 0,
        score: 0,
      ));
    } on QuizFailure catch (failure) {
      if (isClosed) return;
      emit(QuizError(failure.message));
    }
  }

  void selectAnswer(int selectedIndex) {
    final current = state;
    if (current is! QuizInProgress || current.isAnswered) return;

    final isCorrect = current.currentQuestion.isCorrect(selectedIndex);

    emit(QuizInProgress(
      questions: current.questions,
      currentIndex: current.currentIndex,
      score: isCorrect ? current.score + 1 : current.score,
      selectedIndex: selectedIndex,
    ));
  }

  void nextQuestion() {
    final current = state;
    if (current is! QuizInProgress || !current.isAnswered) return;

    if (current.isLastQuestion) {
      emit(QuizFinished(
        score: current.score,
        total: current.questions.length,
      ));
      return;
    }

    emit(QuizInProgress(
      questions: current.questions,
      currentIndex: current.currentIndex + 1,
      score: current.score,
    ));
  }
}
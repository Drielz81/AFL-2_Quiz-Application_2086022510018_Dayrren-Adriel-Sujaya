import 'package:equatable/equatable.dart';
import 'package:afl2/features/Quiz/domain/entities/question.dart';

sealed class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState { const QuizInitial(); } //belum diload soalnya
class QuizLoading extends QuizState { const QuizLoading(); } //lagi loading soalnya

class QuizInProgress extends QuizState { //lagi dikerja soalnya
  const QuizInProgress({
    required this.questions,
    required this.currentIndex,
    required this.score,
    this.selectedIndex,
  });

  final List<Question> questions;
  final int currentIndex;
  final int score;

  final int? selectedIndex;

  Question get currentQuestion => questions[currentIndex];
  bool get isAnswered => selectedIndex != null;
  bool get isLastQuestion => currentIndex == questions.length - 1;

  @override
  List<Object?> get props => [questions, currentIndex, score, selectedIndex];
}

class QuizFinished extends QuizState { //quiz selesai dikerja
  const QuizFinished({required this.score, required this.total});

  final int score;
  final int total;

  @override
  List<Object?> get props => [score, total];
}

class QuizError extends QuizState { //gagal load quiz, menampilkan pesan error
  const QuizError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
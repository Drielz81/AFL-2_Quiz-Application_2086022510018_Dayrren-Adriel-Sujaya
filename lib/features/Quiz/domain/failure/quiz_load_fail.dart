class QuizFailure implements Exception {
  const QuizFailure(this.message);
  final String message;
}
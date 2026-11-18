import 'package:afl2/features/Quiz/domain/entities/question.dart';
import 'package:afl2/features/Quiz/domain/entities/quiz_category.dart';

abstract class QuizRepository {
  Future<List<Question>> getQuestions(QuizCategory category);
}
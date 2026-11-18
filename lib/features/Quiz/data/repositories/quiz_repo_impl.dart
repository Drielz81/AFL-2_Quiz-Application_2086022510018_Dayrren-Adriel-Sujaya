import 'package:afl2/features/Quiz/domain/entities/question.dart';
import 'package:afl2/features/Quiz/domain/entities/quiz_category.dart';
import 'package:afl2/features/Quiz/domain/failure/quiz_load_fail.dart';
import 'package:afl2/features/Quiz/domain/repository/quiz_repository.dart';
import 'package:afl2/features/Quiz/data/datasources/quiz_data_processor.dart';

class QuizRepositoryImpl implements QuizRepository {
  const QuizRepositoryImpl(this._dataSource);

  final QuizDataProcessor _dataSource;

  @override
  Future<List<Question>> getQuestions(QuizCategory category) async {
    try {
      final questions = await _dataSource.getQuestions(category);

      if (questions.isEmpty) {
        throw const QuizFailure('Belum ada soal untuk kategori ini.');
      }

      return questions;
    } on QuizFailure {
      rethrow;
    } on FormatException {
      throw const QuizFailure(
        'Data soal tidak bisa dibaca. Silakan coba kategori lain.',
      );
    } catch (_) {
      throw const QuizFailure(
        'Soal tidak bisa dimuat saat ini. Silakan coba lagi.',
      );
    }
  }
}
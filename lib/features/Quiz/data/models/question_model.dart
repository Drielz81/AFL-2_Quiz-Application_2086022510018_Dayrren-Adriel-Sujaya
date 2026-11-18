import 'package:afl2/features/Quiz/domain/entities/question.dart';

class QuestionModel extends Question {
  const QuestionModel({
    required super.id,
    required super.text,
    required super.options,
    required super.correctOptionIndex,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    final options = List<String>.from(json['options'] as List);
    final correctOptionIndex = json['correctOptionIndex'] as int;

    if (correctOptionIndex < 0 || correctOptionIndex >= options.length) {
      throw FormatException(
        'correctOptionIndex $correctOptionIndex di luar jumlah pilihan (${options.length})',
      );
    }

    return QuestionModel(
      id: json['id'] as String,
      text: json['text'] as String,
      options: options,
      correctOptionIndex: correctOptionIndex,
    );
  }
}
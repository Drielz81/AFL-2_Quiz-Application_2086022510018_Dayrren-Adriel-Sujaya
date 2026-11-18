import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:afl2/features/Quiz/domain/entities/quiz_category.dart';
import 'package:afl2/features/Quiz/data/models/question_model.dart';


class QuizDataProcessor {
  QuizDataProcessor({AssetBundle? bundle}) : _bundle = bundle ?? rootBundle;

  final AssetBundle _bundle;

  Future<List<QuestionModel>> getQuestions(QuizCategory category) async {
    final raw = await _bundle.loadString(_assetPath(category));
    final decoded = jsonDecode(raw) as List<dynamic>;

    return decoded.map((item) => QuestionModel.fromJson(item as Map<String, dynamic>)).toList();}

  String _assetPath(QuizCategory category) {
    return switch (category) {
      QuizCategory.general => 'local_data/general.json',
      QuizCategory.biology => 'local_data/biology.json',
      QuizCategory.mathematics => 'local_data/mathematics.json',
      QuizCategory.physics => 'local_data/physics.json',
      QuizCategory.finance => 'local_data/finance.json',
    };
  }
}
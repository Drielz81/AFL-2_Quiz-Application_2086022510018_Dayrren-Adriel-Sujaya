import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:afl2/features/Quiz/domain/entities/question.dart';
import 'package:afl2/features/Quiz/domain/entities/quiz_category.dart';
import 'package:afl2/features/Quiz/domain/failure/quiz_load_fail.dart';
import 'package:afl2/features/Quiz/domain/repository/quiz_repository.dart';
import 'package:afl2/features/Quiz/presentation/cubit/quiz_cubit.dart';
import 'package:afl2/features/Quiz/presentation/cubit/quiz_state.dart';

class FakeQuizRepository implements QuizRepository {
  FakeQuizRepository({this.questions = const [], this.failure, this.gate});

  final List<Question> questions;
  final QuizFailure? failure;

  /// Kalau diisi, getQuestions menunggu sampai gate diselesaikan.
  final Completer<void>? gate;

  @override
  Future<List<Question>> getQuestions(QuizCategory category) async {
    if (gate != null) await gate!.future;
    if (failure != null) throw failure!;
    return questions;
  }
}

const q1 = Question(
  id: 'q1',
  text: 'Soal 1',
  options: ['A', 'B'],
  correctOptionIndex: 1,
);

const q2 = Question(
  id: 'q2',
  text: 'Soal 2',
  options: ['A', 'B'],
  correctOptionIndex: 0,
);

void main() {
  group('QuizCubit', () {
    blocTest<QuizCubit, QuizState>(
      'loadQuiz berhasil: Loading lalu InProgress di soal pertama',
      build: () => QuizCubit(FakeQuizRepository(questions: [q1, q2])),
      act: (cubit) => cubit.loadQuiz(QuizCategory.general),
      expect: () => [
        const QuizLoading(),
        const QuizInProgress(
          questions: [q1, q2],
          currentIndex: 0,
          score: 0,
        ),
      ],
    );

    blocTest<QuizCubit, QuizState>(
      'loadQuiz gagal: Loading lalu Error berisi pesan dari QuizFailure',
      build: () => QuizCubit(
        FakeQuizRepository(failure: const QuizFailure('Soal gagal dimuat.')),
      ),
      act: (cubit) => cubit.loadQuiz(QuizCategory.general),
      expect: () => [
        const QuizLoading(),
        const QuizError('Soal gagal dimuat.'),
      ],
    );

    blocTest<QuizCubit, QuizState>(
      'selectAnswer benar: skor bertambah dan jawaban tercatat',
      build: () => QuizCubit(FakeQuizRepository()),
      seed: () => const QuizInProgress(
        questions: [q1, q2],
        currentIndex: 0,
        score: 0,
      ),
      act: (cubit) => cubit.selectAnswer(1),
      expect: () => [
        const QuizInProgress(
          questions: [q1, q2],
          currentIndex: 0,
          score: 1,
          selectedIndex: 1,
        ),
      ],
    );

    blocTest<QuizCubit, QuizState>(
      'selectAnswer salah: skor tetap, jawaban tetap tercatat',
      build: () => QuizCubit(FakeQuizRepository()),
      seed: () => const QuizInProgress(
        questions: [q1, q2],
        currentIndex: 0,
        score: 0,
      ),
      act: (cubit) => cubit.selectAnswer(0),
      expect: () => [
        const QuizInProgress(
          questions: [q1, q2],
          currentIndex: 0,
          score: 0,
          selectedIndex: 0,
        ),
      ],
    );

    blocTest<QuizCubit, QuizState>(
      'selectAnswer dua kali di soal yang sama: hanya yang pertama dihitung',
      build: () => QuizCubit(FakeQuizRepository()),
      seed: () => const QuizInProgress(
        questions: [q1, q2],
        currentIndex: 0,
        score: 0,
      ),
      act: (cubit) => cubit
        ..selectAnswer(1)
        ..selectAnswer(1),
      expect: () => [
        const QuizInProgress(
          questions: [q1, q2],
          currentIndex: 0,
          score: 1,
          selectedIndex: 1,
        ),
      ],
    );

    blocTest<QuizCubit, QuizState>(
      'nextQuestion di soal terakhir: emit QuizFinished dengan skor akhir',
      build: () => QuizCubit(FakeQuizRepository()),
      seed: () => const QuizInProgress(
        questions: [q1, q2],
        currentIndex: 1,
        score: 1,
        selectedIndex: 0,
      ),
      act: (cubit) => cubit.nextQuestion(),
      expect: () => [
        const QuizFinished(score: 1, total: 2),
      ],
    );

    test('Cubit ditutup saat soal masih dimuat: tidak ada emit dan tidak error',
        () async {
      final gate = Completer<void>();
      final cubit = QuizCubit(
        FakeQuizRepository(questions: [q1, q2], gate: gate),
      );
      final states = <QuizState>[];
      final subscription = cubit.stream.listen(states.add);

      final loading = cubit.loadQuiz(QuizCategory.general);
      await cubit.close();
      gate.complete();

      await loading; // kalau guard isClosed hilang, baris ini melempar error

      expect(states.whereType<QuizInProgress>(), isEmpty);
      await subscription.cancel();
    });
  });
}
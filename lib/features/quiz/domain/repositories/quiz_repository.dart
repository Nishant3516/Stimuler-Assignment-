import 'package:dartz/dartz.dart';
import 'package:stimuler/core/failures/failures.dart';
import 'package:stimuler/features/quiz/domain/entities/day.dart';
import 'package:stimuler/features/quiz/domain/entities/question.dart';

abstract class QuizRepository {
  Future<Either<Failure, List<Day>>> getDays();
  Future<Either<Failure, void>> updateExerciseCompletion(
      String day, String exerciseTitle);
}

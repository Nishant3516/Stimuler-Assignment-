import 'package:dartz/dartz.dart';
import 'package:stimuler/core/failures/failures.dart';
import 'package:stimuler/features/quiz/domain/repositories/quiz_repository.dart';

class UpdateCompletionStatus {
  final QuizRepository repository;

  UpdateCompletionStatus(this.repository);

  Future<Either<Failure, void>> call(String day, String exerciseTitle) {
    return repository.updateExerciseCompletion(day, exerciseTitle);
  }
}

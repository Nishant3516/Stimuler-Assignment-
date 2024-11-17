import 'package:dartz/dartz.dart';
import 'package:stimuler/core/failures/failures.dart';
import 'package:stimuler/features/quiz/domain/entities/day.dart';
import 'package:stimuler/features/quiz/domain/entities/question.dart';
import 'package:stimuler/features/quiz/domain/repositories/quiz_repository.dart';

class GetDays {
  final QuizRepository repository;

  GetDays(this.repository);

  Future<Either<Failure, List<Day>>> call() {
    return repository.getDays();
  }
}

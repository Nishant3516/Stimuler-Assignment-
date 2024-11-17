import 'package:dartz/dartz.dart';
import 'package:stimuler/core/failures/failures.dart';
import 'package:stimuler/features/quiz/data/datasources/quiz_local_datasource.dart';
import 'package:stimuler/features/quiz/domain/entities/day.dart';
import 'package:stimuler/features/quiz/domain/entities/question.dart';
import 'package:stimuler/features/quiz/domain/repositories/quiz_repository.dart';

class QuizRepositoryImpl extends QuizRepository {
  final QuizLocalDataSource localDataSource;

  QuizRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<Day>>> getDays() async {
    try {
      return Right(localDataSource.getDays());
    } catch (e) {
      return Left(CacheFailure(""));
    }
  }

  @override
  Future<Either<Failure, void>> updateExerciseCompletion(
      String day, String exerciseTitle) async {
    try {
      // Logic to mark exercise as completed locally
      return Right(null);
    } catch (e) {
      return Left(CacheFailure(""));
    }
  }
}

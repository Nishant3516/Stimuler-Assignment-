import 'package:stimuler/features/quiz/domain/entities/exercise.dart';
import 'package:stimuler/features/quiz/domain/entities/question.dart';

class Day {
  final int? id;
  final String day;
  final String title;
  final List<Exercise> exercises;
  final bool isCompleted;
  final bool isLocked;
  final bool isCurrent;

  Day({
    required this.day,
    required this.title,
    required this.exercises,
    this.isCompleted = false,
    this.isLocked = false,
    this.isCurrent = false,
    this.id,
  });
}

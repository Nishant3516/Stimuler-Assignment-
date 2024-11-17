import 'package:stimuler/features/quiz/data/models/exercise_model.dart';
import 'package:stimuler/features/quiz/domain/entities/day.dart';
import 'package:stimuler/features/quiz/domain/entities/exercise.dart';

class DayModel extends Day {
  DayModel({
    required String day,
    required String title,
    required List<Exercise> exercises,
    bool isCompleted = false,
    bool isLocked = false,
    bool isCurrent = false,
    int? id,
  }) : super(
          day: day,
          title: title,
          exercises: exercises,
          isCompleted: isCompleted,
          isLocked: isLocked,
          isCurrent: isCurrent,
          id: id,
        );

  factory DayModel.fromJson(Map<String, dynamic> json) {
    return DayModel(
      day: json['day'],
      title: json['title'],
      exercises: (json['exercises'] as List)
          .map((e) => ExerciseModel.fromJson(
              e)) // Convert each exercise to ExerciseModel
          .toList()
          .cast<Exercise>(), // Cast to List<Exercise> (from ExerciseModel)
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'title': title,
      'exercises': exercises
          .map((e) => ExerciseModel.fromEntity(e)
              .toJson()) // Convert each Exercise entity to ExerciseModel
          .toList(),
    };
  }

  // CopyWith Method
  DayModel copyWith({
    String? day,
    String? title,
    List<Exercise>? exercises,
    bool? isCompleted,
    bool? isLocked,
    bool? isCurrent,
    int? id,
  }) {
    return DayModel(
      day: day ?? this.day,
      title: title ?? this.title,
      exercises: exercises ?? this.exercises,
      isCompleted: isCompleted ?? this.isCompleted,
      isLocked: isLocked ?? this.isLocked,
      isCurrent: isCurrent ?? this.isCurrent,
      id: id ?? this.id,
    );
  }
}

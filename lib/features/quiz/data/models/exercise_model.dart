import 'package:stimuler/features/quiz/data/models/day_model.dart';
import 'package:stimuler/features/quiz/data/models/question_model.dart';
import 'package:stimuler/features/quiz/domain/entities/exercise.dart';
import 'package:stimuler/features/quiz/domain/entities/question.dart';

class ExerciseModel extends Exercise {
  ExerciseModel({
    required super.title,
    required super.questions,
    super.isCompleted,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      title: json['title'],
      questions: (json['questions'] as List)
          .map((e) => QuestionModel.fromJson(e))
          .toList(),
    );
  }

  factory ExerciseModel.fromEntity(Exercise exercise) {
    return ExerciseModel(
      title: exercise.title,
      questions: exercise.questions
          .map((q) => QuestionModel.fromEntity(q))
          .toList(), // Convert each Question entity to a QuestionModel
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'questions': questions
          .map((q) => QuestionModel.fromEntity(q).toJson())
          .toList(), // Map each question to its JSON
    };
  }
}

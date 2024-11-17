import 'package:equatable/equatable.dart';
import 'package:stimuler/features/quiz/domain/entities/question.dart';

class Exercise extends Equatable {
  final String title;
  final List<Question> questions;
  final bool isCompleted;

  Exercise({
    required this.title,
    required this.questions,
    this.isCompleted = false,
  });

  @override
  List<Object?> get props => [title, questions, isCompleted];
}

part of 'quiz_bloc.dart';

abstract class QuizEvent {}

class LoadDaysEvent extends QuizEvent {}

class GetDaysEvent extends QuizEvent {}

class CompleteExerciseEvent extends QuizEvent {
  final String day;
  final String exerciseTitle;

  CompleteExerciseEvent(this.day, this.exerciseTitle);
}

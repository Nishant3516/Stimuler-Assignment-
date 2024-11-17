part of 'quiz_bloc.dart';

abstract class QuizState {}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final List<Day> days;

  QuizLoaded(this.days);
}

class QuizError extends QuizState {}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stimuler/features/quiz/domain/entities/day.dart';
import 'package:stimuler/features/quiz/domain/entities/question.dart';
import 'package:stimuler/features/quiz/domain/usecases/get_day_exercises.dart';
import 'package:stimuler/features/quiz/domain/usecases/get_days_usecase.dart';
import 'package:stimuler/features/quiz/domain/usecases/mark_day_complete_usecase.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final GetDays getDays;
  final GetDayExercises getDayExercises;
  final UpdateCompletionStatus updateCompletionStatus;

  QuizBloc(this.getDays, this.getDayExercises, this.updateCompletionStatus)
      : super(QuizInitial()) {
    on<GetDaysEvent>((event, emit) async {
      emit(QuizLoading());
      final result = await getDays();
      result.fold(
        (failure) => emit(QuizError()),
        (days) => emit(QuizLoaded(days)),
      );
    });
    on<LoadDaysEvent>((event, emit) async {
      emit(QuizLoading());
      final result = await getDayExercises();
      result.fold(
        (failure) => emit(QuizError()),
        (days) => emit(QuizLoaded(days)),
      );
    });

    on<CompleteExerciseEvent>((event, emit) async {
      final currentState = state;
      if (currentState is QuizLoaded) {
        await updateCompletionStatus(event.day, event.exerciseTitle);
        // Logic to update state
      }
    });
  }
}

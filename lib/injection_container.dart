import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:stimuler/features/quiz/data/datasources/quiz_local_datasource.dart';
import 'package:stimuler/features/quiz/data/repositories/quiz_repository_impl.dart';
import 'package:stimuler/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:stimuler/features/quiz/domain/usecases/get_day_exercises.dart';
import 'package:stimuler/features/quiz/domain/usecases/get_days_usecase.dart';
import 'package:stimuler/features/quiz/domain/usecases/mark_day_complete_usecase.dart';
import 'package:stimuler/features/quiz/presentation/bloc/quiz_bloc.dart';

final sl = GetIt.instance; // sl stands for Service Locator

// This function will be called to set up all the dependencies.
Future<void> init() async {
  final jsonData = await _loadJsonData();
  // Data sources
  sl.registerLazySingleton<QuizLocalDataSource>(
      () => QuizLocalDataSourceImpl(jsonData));

  // Repositories
  sl.registerLazySingleton<QuizRepository>(() => QuizRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton<GetDays>(() => GetDays(sl()));
  sl.registerLazySingleton<GetDayExercises>(() => GetDayExercises(sl()));
  sl.registerLazySingleton<UpdateCompletionStatus>(
      () => UpdateCompletionStatus(sl()));

  // // BLoC or Cubit
  sl.registerFactory<QuizBloc>(() => QuizBloc(sl(), sl(), sl()));
}

Future<List<Map<String, dynamic>>> _loadJsonData() async {
  try {
    // Load the data.json file as a string
    final String response =
        await rootBundle.loadString('assets/data/data.json');

    // Decode the JSON string into a Map (not a List)
    final Map<String, dynamic> data = json.decode(response);

    // Access the 'days' key to get the list of maps
    final List<dynamic> days = data['days'];

    // Return the list of maps (with casting)
    return List<Map<String, dynamic>>.from(days);
  } catch (e) {
    throw Exception('Error loading JSON data: $e');
  }
}

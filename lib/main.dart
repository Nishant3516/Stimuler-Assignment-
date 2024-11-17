import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimuler/core/themes/theme.dart';
import 'package:stimuler/features/curved_path/presentation/screens/curved_path_screen.dart';
import 'package:stimuler/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:stimuler/features/quiz/presentation/screens/quiz_screen.dart';
import 'package:stimuler/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      PathItem(title: 'Adjectives'),
      PathItem(title: 'Adverbs'),
      PathItem(title: 'Conjunctions'),
      PathItem(title: 'Prefix & Suffix'),
      PathItem(title: 'Sentence structure'),
      PathItem(title: 'Verbs'),
    ];

    return MaterialApp(
      theme: customTheme,
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<QuizBloc>()..add(GetDaysEvent())),
        ],
        child: CurvedZigzagPathProgress(),
      ),
      // CurvedZigzagPathProgress(
      //   items: items,
      //   labelStyle: const TextStyle(
      //     fontSize: 14,
      //     fontWeight: FontWeight.bold,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }
}

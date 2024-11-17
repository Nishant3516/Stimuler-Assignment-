import 'package:stimuler/features/quiz/domain/entities/question.dart';

class QuestionModel extends Question {
  QuestionModel({
    required super.question,
    required super.options,
    required super.answer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'],
      options: List<String>.from(json['options']),
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionText': question,
      'options': options,
      'correctAnswer': answer,
    };
  }

  factory QuestionModel.fromEntity(Question question) {
    return QuestionModel(
      question: question.question,
      options: question.options,
      answer: question.answer,
    );
  }
}

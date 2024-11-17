import 'package:stimuler/features/quiz/data/models/day_model.dart';

abstract class QuizLocalDataSource {
  List<DayModel> getDays();
}

class QuizLocalDataSourceImpl extends QuizLocalDataSource {
  final List<Map<String, dynamic>> jsonData;

  QuizLocalDataSourceImpl(this.jsonData);

  @override
  List<DayModel> getDays() {
    return jsonData.map((e) => DayModel.fromJson(e)).toList();
  }
}

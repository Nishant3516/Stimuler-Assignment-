import 'package:flutter/material.dart';
import 'package:stimuler/features/quiz/presentation/widgets/ind_option.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentPage = 0;
  List<Map<String, dynamic>> _questions = [
    {
      "question":
          "The company implemented a _ security protocol for their data centers.",
      "options": [
        "cutting-edge",
        "cutting edge",
        "edge-cutting",
        "edge cutting"
      ],
      "answer": "cutting-edge",
    },
    {
      "question":
          "The physicist presented a _ theory about quantum entanglement.",
      "options": [
        "ground breaking",
        "ground-breaking",
        "breaking-ground",
        "break-grounding"
      ],
      "answer": "ground-breaking",
    },
    {
      "question":
          "The expedition required _ equipment for the harsh Antarctic conditions.",
      "options": [
        "military grade",
        "military-grade",
        "grade-military",
        "grade military"
      ],
      "answer": "military-grade",
    },
  ];

  String _selectedAnswer = "";
  bool _answerChecked = false; // Flag to track if the answer has been checked
  bool _isCorrect = false;
  String _buttonText = "Check Answer";
  Color _buttonColor = Colors.blueAccent[400]!.withOpacity(0.8);
  bool _showProceedButton = false;

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentPage];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: Text('Grammar Practice'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.flag_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween<double>(
                  begin: (_currentPage) / _questions.length,
                  end: (_currentPage + 1) / _questions.length),
              duration: Duration(milliseconds: 500),
              builder: (context, value, child) {
                return LinearProgressIndicator(
                  value: value,
                  color: Colors.green,
                  minHeight: 12,
                  borderRadius: BorderRadius.circular(100),
                );
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Q${_currentPage + 1}. Fill in the blanks",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      question['question']
                          .toString()
                          .replaceAll("_", "_________"),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 24.0),
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/icons/quiz_ic.png",
                        height: MediaQuery.sizeOf(context).height * 0.25,
                      ),
                    ),
                    SizedBox(height: 24.0),
                    ListView.separated(
                      itemCount: question['options'].length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, _) => SizedBox(height: 12.0),
                      itemBuilder: (context, index) {
                        final answer = question['answer'];
                        return IndOption(
                          key: ValueKey(question['options'][index]),
                          onPressed: _answerChecked
                              ? null
                              : () {
                                  setState(() {
                                    _selectedAnswer =
                                        question['options'][index];
                                    _answerChecked = false;
                                  });
                                },
                          text: question["options"][index],
                          index: index,
                          selectedAnswer: _selectedAnswer,
                          answer: answer,
                          answerChecked: _answerChecked,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _showProceedButton
                    ? _navigateToNextQuestion
                    : () {
                        setState(() {
                          _answerChecked = true;
                          if (_selectedAnswer == question['answer']) {
                            _isCorrect = true;
                            _buttonText = "Great Work!";
                            _buttonColor = Colors.green;
                            _showProceedButton = false;
                          } else {
                            _isCorrect = false;
                            _buttonText = "That Wasn't Right!";
                            _buttonColor = Colors.red;
                            _showProceedButton = false;
                            _showIncorrectDialog();
                          }
                        });

                        if (_isCorrect) {
                          Future.delayed(Duration(seconds: 2), () {
                            setState(() {
                              _buttonText = "Proceed to Next Question";
                              _buttonColor =
                                  Colors.blueAccent[400]!.withOpacity(0.8);
                              _showProceedButton = true;
                            });
                          });
                        }
                      },
                style: ElevatedButton.styleFrom(
                    backgroundColor: _buttonColor,
                    padding: EdgeInsets.symmetric(vertical: 16)),
                child: Text(_buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToNextQuestion() {
    setState(() {
      _currentPage++;
      _selectedAnswer = "";
      _answerChecked = false;
      _isCorrect = false;
      _buttonText = "Check Answer";
      _buttonColor = Colors.blueAccent[400]!.withOpacity(0.8);
      _showProceedButton = false;
    });
  }

  void _showIncorrectDialog() {
    showModalBottomSheet(
      // backgroundColor: Colors.red.withOpacity(0.7),
      isDismissible: false,
      showDragHandle: false,
      enableDrag: false,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.3),
                borderRadius: BorderRadius.circular(30)),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.redAccent[200]!.withOpacity(0.2),
                      foregroundColor: Colors.red,
                      radius: 25,
                      child: Icon(
                        Icons.close,
                        color: Colors.red.withOpacity(0.3),
                        size: 40,
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Incorrect Answer"),
                        Text(
                          "The correct answer is ${_questions[_currentPage]['answer']}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 16),
                Text(
                    "\"Placed\" is the past tense of \"place,\" fitting the past action in the sentence. \"Placing\" is the present participle, and \"place\" is the base form, both of which do not fit the past tense required by the sentence context."),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.brown[900]!.withOpacity(0.3)),
                      onPressed: () {
                        _navigateToNextQuestion();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Continue to next question",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       title: Text('Incorrect'),
    //       content: Text('Please try again.'),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //             setState(() {
    //               _selectedAnswer = "";
    //               _answerChecked = false;
    //             });
    //           },
    //           child: Text('OK'),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}

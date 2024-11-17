import 'package:flutter/material.dart';

class IndOption extends StatelessWidget {
  final void Function()? onPressed; // Changed to nullable to disable
  final String text;
  final int index;
  final String selectedAnswer;
  final String answer;
  final bool answerChecked;

  const IndOption({
    super.key,
    required this.onPressed,
    required this.text,
    required this.index,
    required this.selectedAnswer,
    required this.answer,
    required this.answerChecked,
  });

  @override
  Widget build(BuildContext context) {
    Color optionColor;

    if (answerChecked) {
      if (text == answer) {
        optionColor = Colors.green;
      } else if (selectedAnswer == text) {
        optionColor = Colors.red;
      } else {
        optionColor = Colors.transparent;
      }
    } else {
      optionColor = selectedAnswer == text
          ? Colors.blueAccent[400]!.withOpacity(0.8)
          : Colors.transparent;
    }

    return GestureDetector(
      onTap:
          onPressed, // This will be null when the answer is checked, disabling interaction
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: optionColor,
          border: Border.all(
            color: Colors.grey[100]!.withOpacity(0.3),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[100]!.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(String.fromCharCode(65 + index)),
            ),
            Spacer(),
            Text(text),
            Spacer()
          ],
        ),
      ),
    );
  }
}

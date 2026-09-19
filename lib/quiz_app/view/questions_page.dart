import 'package:flutter/material.dart';

import '../controller/quiz_controller.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  final quizController = QuizController();
  int questionIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    questionIndex = quizController.questionIndex;
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz App", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            Text("Question (${questionIndex + 1})"),
            //Title of Question
            Text(
              quizController.questions[questionIndex].questionTitle,
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: quizController.getProgress(),
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(width: 15),
                SizedBox(height: 12),
                Text("${(quizController.getProgress() * 100).toInt()} %"),
              ],
            ),

            SizedBox(height: 100),
            //Answers
            Column(
              children: [
                RadioListTile<String>(
                  title: Text(
                    quizController.questions[questionIndex].answers[0],
                  ),
                  value: quizController.questions[questionIndex].answers[0],
                  groupValue: quizController.selectedValue,
                  onChanged: (v) {
                    quizController.selectedValue = v as String;
                    setState(() {});
                  },
                ),
                RadioListTile<String>(
                  title: Text(
                    quizController.questions[questionIndex].answers[1],
                  ),
                  value: quizController.questions[questionIndex].answers[1],
                  groupValue: quizController.selectedValue,
                  onChanged: (v) {
                    quizController.selectedValue = v as String;
                    setState(() {});
                  },
                ),
                RadioListTile<String>(
                  title: Text(
                    quizController.questions[questionIndex].answers[2],
                  ),
                  value: quizController.questions[questionIndex].answers[2],
                  groupValue: quizController.selectedValue,
                  onChanged: (v) {
                    quizController.selectedValue = v as String;
                    setState(() {});
                  },
                ),
              ],
            ),
            SizedBox(height: 50),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: quizController.selectedValue == null
                    ? null
                    : () {
                        quizController.nextQuestion();
                        quizController.selectedValue = null;
                        setState(() {});
                      },
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 20,
                    color: quizController.selectedValue == null
                        ? Colors.grey
                        : null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// MVC
/// Model - View - Controller

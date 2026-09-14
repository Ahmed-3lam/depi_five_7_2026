import 'package:depi_five/quiz_app/model/question_model.dart';

class QuizController {
  String? selectedValue;
  int questionIndex = 0;
  final List<QuestionModel> questions = [
    QuestionModel(
      questionTitle: "What is the capital of Egypt?",
      answers: ["Cairo", "Alexandria", "Giza"],
      correctAnswer: "Cairo",
    ),
    QuestionModel(
      questionTitle: "What is the capital of France?",
      answers: ["Paris", "Lyon", "Marseille"],
      correctAnswer: "Paris",
    ),
    QuestionModel(
      questionTitle: "What is the capital of Sudan?",
      answers: ["Khartoum", "Omdurman", "Port Sudan"],
      correctAnswer: "Khartoum",
    ),
    QuestionModel(
      questionTitle: "What is the capital of Germany?",
      answers: ["Berlin", "Munich", "Frankfurt"],
      correctAnswer: "Berlin",
    ),
    QuestionModel(
      questionTitle: "What is the capital of Italy?",
      answers: ["Rome", "Milan", "Naples"],
      correctAnswer: "Rome",
    ),
    QuestionModel(
      questionTitle: "What is the capital of Spain?",
      answers: ["Madrid", "Barcelona", "Valencia"],
      correctAnswer: "Madrid",
    ),
  ];

  double getProgress() {
    return (questionIndex + 1) / questions.length;
  }

  void nextQuestion() {
    questionIndex++;
  }
}

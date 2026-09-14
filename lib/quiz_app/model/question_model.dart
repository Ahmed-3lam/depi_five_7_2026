class QuestionModel {
  final String questionTitle;
  final List<String> answers;
  final String correctAnswer;
  QuestionModel({
    required this.questionTitle,
    required this.answers,
    required this.correctAnswer,
  });
}

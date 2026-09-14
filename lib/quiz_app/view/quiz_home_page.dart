import 'package:depi_five/quiz_app/view/questions_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizHomePage extends StatefulWidget {
  const QuizHomePage({super.key});

  @override
  State<QuizHomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Icon(Icons.lightbulb, size: 130, color: Colors.amber),
              SizedBox(height: 30),
              Text(
                "Quiz App",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                "Test your knowledge challange yourself",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              SizedBox(height: 200),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(QuestionsPage());

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const QuestionsPage(),
                    //   ),
                    // );
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => QuestionsPage()),
                    // );
                  },
                  child: Text("Start Quiz →", style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:depi_five/quiz_app/view/quiz_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultPage extends StatefulWidget {
  final int score;
  const ResultPage({super.key, required this.score});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 300, horizontal: 30),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            Text(
              "Your Result is ${widget.score}",
              style: TextStyle(fontSize: 50),
            ),

            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.offAll(QuizHomePage());
                },
                child: Text("Restart Quiz", style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

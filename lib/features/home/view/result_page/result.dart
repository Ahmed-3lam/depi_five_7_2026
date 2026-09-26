import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;

  ResultScreen({
    this.score = 8,
    this.total = 10,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = score / total;

    String resultText;

    if (percentage >= 0.8) {
      resultText = "Excellent!";
    } else if (percentage >= 0.5) {
      resultText = "Good Job!";
    } else {
      resultText = "Try Again!";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
        centerTitle: true,
      ),

      body: Center(
        child: Padding(
          padding: EdgeInsets.all(25),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(
                Icons.emoji_events,
                size: 100,
                color: Colors.orange,
              ),

              SizedBox(height: 25),

              Text(
                "Your Result",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 15),

              Text(
                "$score / $total",
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              SizedBox(height: 15),

              Text(
                resultText,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  child: Text(
                    "Back",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
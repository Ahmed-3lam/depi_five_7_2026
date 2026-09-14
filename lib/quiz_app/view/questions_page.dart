import 'package:flutter/material.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  List<String> answers = ["Egypt", "France", "Sudan"];
  var selectedValue = "";
  @override
  void initState() {
    selectedValue = answers[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            Text("Question (1)"),
            SizedBox(height: 12),
            Text("Question Title", style: TextStyle(fontSize: 30)),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: .8,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(width: 15),
                Text("80 %"),
              ],
            ),

            SizedBox(height: 100),
            Column(
              children: [
                RadioListTile<String>(
                  title: Text(answers[0]),
                  value: answers[0],
                  groupValue: selectedValue,
                  onChanged: (v) {
                    selectedValue = v as String;
                    setState(() {});
                  },
                ),
                RadioListTile<String>(
                  title: Text(answers[1]),
                  value: answers[1],
                  groupValue: selectedValue,
                  onChanged: (v) {
                    selectedValue = v as String;
                    setState(() {});
                  },
                ),
                RadioListTile<String>(
                  title: Text(answers[2]),
                  value: answers[2],
                  groupValue: selectedValue,
                  onChanged: (v) {
                    selectedValue = v as String;
                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



/// MVC
/// Model - View - Controller

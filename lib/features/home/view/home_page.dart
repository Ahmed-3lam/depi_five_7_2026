import 'package:depi_five/features/home/view/result_page/result.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Icon(Icons.menu), title: Text("AppBar")),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
            
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(score: 7, total: 10),
                  ),
                );
              },
              child: Text("Show Result"),
            ),
          ],
        ),
      ),
    );
  }
}

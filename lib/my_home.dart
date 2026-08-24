import 'package:flutter/material.dart';

import 'const.dart';
import 'home_widgets.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 5,
        title: Text(
          "My Profile",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 40),
            myImage(),
            SizedBox(height: 30),

            Text(
              "Ahmed Allam",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Flutter Developer",
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
            SizedBox(height: 20),
            Container(
              height: 200,
              width: 300,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                spacing: 10,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue.withOpacity(.1),
                        child: Icon(
                          Icons.person_2_outlined,
                          color: Colors.blue,
                        ),
                      ),

                      Text(
                        "Welcome to my profile",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Divider(color: Colors.blue.withOpacity(.2)),
                  Text(
                    """
I'm learning flutter I'm learning 
I'm learning flutter I'm learning 
I'm learning flutter I'm learning 
                      """,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

enum Type { Male, Female }

class BmiCalcPage extends StatefulWidget {
  const BmiCalcPage({super.key});

  @override
  State<BmiCalcPage> createState() => _BmiCalcPageState();
}

class _BmiCalcPageState extends State<BmiCalcPage> {
  Type type = Type.Male;
  double height = 158;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 19, 38),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 19, 38),
        centerTitle: false,
        title: Text(
          "BMI CALCULATOR",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(Icons.refresh, color: Colors.white, size: 25),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 30,
          children: [
            Row(
              spacing: 20,
              children: [
                /// 2x + 2x = 4
                /// x = 1
                Expanded(
                  child: InkWell(
                    onTap: () {
                      type = Type.Male;
                      setState(() {});
                    },
                    child: Container(
                      height: 190,
                      decoration: BoxDecoration(
                        color: type == Type.Male
                            ? Colors.red
                            : Colors.black.withOpacity(.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "Male",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      type = Type.Female;
                      setState(() {});
                    },
                    child: Container(
                      height: 190,
                      decoration: BoxDecoration(
                        color: type == Type.Female
                            ? Colors.red
                            : Colors.black.withOpacity(.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "Female",
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 250,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    "Height",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        height.toInt().toString(),
                        style: TextStyle(fontSize: 80, color: Colors.white),
                      ),
                      Text(
                        "cm",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                  Slider(
                    thumbColor: Colors.red,
                    activeColor: Colors.red,
                    min: 70,
                    max: 220,
                    value: height,
                    onChanged: (value) {
                      print("Value is $value");
                      height = value;
                      setState(() {});
                    },
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

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
  int weight = 0;
  int age = 0;

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
          spacing: 20,
          children: [
            Expanded(
              flex: 2,
              child: Row(
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
            ),
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text("Height", style: _titleStyle()),
                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        Text(height.toInt().toString(), style: _numberStyle()),
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
            ),

            Expanded(
              flex: 3,
              child: Row(
                spacing: 20,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text("WEIGHT", style: _titleStyle()),
                          Spacer(),

                          Text(weight.toString(), style: _numberStyle()),

                          Spacer(),
                          Row(
                            children: [
                              FloatingActionButton(
                                onPressed: () {
                                  weight++;
                                  setState(() {});
                                },
                                backgroundColor: Colors.grey,
                                shape: CircleBorder(),
                                child: Icon(Icons.add),
                              ),
                              Spacer(),
                              FloatingActionButton(
                                onPressed: () {
                                  weight--;
                                  setState(() {});
                                },
                                backgroundColor: Colors.grey,
                                shape: CircleBorder(),
                                child: Icon(Icons.remove),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text("Age", style: _titleStyle()),
                          Spacer(),

                          Text(age.toString(), style: _numberStyle()),
                          Spacer(),
                          Row(
                            children: [
                              FloatingActionButton(
                                onPressed: () {
                                  age++;
                                  setState(() {});
                                },
                                backgroundColor: Colors.grey,
                                shape: CircleBorder(),
                                child: Icon(Icons.add),
                              ),
                              Spacer(),
                              FloatingActionButton(
                                onPressed: () {
                                  age--;
                                  setState(() {});
                                },
                                backgroundColor: Colors.grey,
                                shape: CircleBorder(),
                                child: Icon(Icons.remove),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                var result = "";
                double bmi = (weight) / (height * height / 10000);
                if (bmi < 18.5) {
                  result = "Underweight";
                } else if (bmi < 24.9) {
                  result = "Healthy weight";
                } else if (bmi < 29.9) {
                  result = "Overweight";
                } else {
                  result = "Obese";
                }
                

                // show the dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("BMI Result"),
                      content: Text("Your Bmi is ${bmi.toInt()} you are $result"),
                    );
                  },
                );
              },
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text("Check Your BMI", style: _titleStyle()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _numberStyle() => TextStyle(fontSize: 80, color: Colors.white);

  TextStyle _titleStyle() => TextStyle(color: Colors.white, fontSize: 20);
}

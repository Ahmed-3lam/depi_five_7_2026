import 'dart:async';

import 'package:depi_five/core/const/colors.dart' show MyColors;
import 'package:depi_five/core/const/image_paths.dart';
import 'package:depi_five/core/widgets/primary_btn.dart';
import 'package:depi_five/features/auth/view/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseAuthPage extends StatefulWidget {
  const BaseAuthPage({super.key});

  @override
  State<BaseAuthPage> createState() => _BaseAuthPageState();
}

class _BaseAuthPageState extends State<BaseAuthPage> {
  var count = 1;

  void _startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (count == 1) {
        count = 2;
      } else {
        count = 1;
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    _startCountdown();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              "${rootImagePath}auth_background$count.png",
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 130,
              left: 30,
              right: 30,
              bottom: 30,
            ),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  "Welcome to our  ",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
                ),
                Text(
                  "E-Grocery",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    color: MyColors.primaryColor,
                  ),
                ),
                Spacer(),
                PrimaryBtn.greenBtn(
                  "Continue with Email or Phone",
                  onTap: () {
                    Get.to(LoginPage());
                  },
                ),
                SizedBox(height: 20),
                PrimaryBtn.whiteBtn("Create an account"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

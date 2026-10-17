import 'package:depi_five/core/helpers/hive_helper.dart';
import 'package:depi_five/features/auth/view/pages/base_auth_page.dart';
import 'package:depi_five/features/onboarding/onboarding_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/const/image_paths.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  var count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: .center,
          spacing: 20,
          children: [
            SizedBox(
              height: 350,
              width: 350,
              child: Image.asset("${rootImagePath}onboarding$count.png"),
            ),
            Text(
              titles[count - 1],
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
            ),
            Text(
              descriptions[count - 1],
              textAlign: .center,
              style: TextStyle(color: Color(0xFF16162E)),
            ),
            SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                if (count < 3) {
                  count++;
                  setState(() {});
                } else {
                  HiveHelper.saveOnboardingEntry();
                  Get.offAll(BaseAuthPage());
                }
              },
              child: Image.asset(
                "${rootImagePath}next$count.png",
                height: 88,
                width: 88,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

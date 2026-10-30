import 'dart:async';
import 'package:depi_five/core/helpers/hive_helper.dart';
import 'package:depi_five/features/auth/view/pages/base_auth_page.dart';
import 'package:depi_five/features/home/view/home_page.dart';
import 'package:depi_five/features/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/const/image_paths.dart' show rootImagePath;

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var color = Color(0xFF40AA54);
  var image = "assets/images/logo1.png";
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    int counter = 2;

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      counter--;

      if (counter == 0) {
        timer.cancel();
        if (HiveHelper.getToken()) {
          Get.offAll(() => const HomePage());
        } else if (HiveHelper.isOnboardingSeen()) {
          Get.offAll(() => const BaseAuthPage());
        } else {
          Get.offAll(() => const OnboardingPage());
        }
      } else {
        setState(() {
          if (color == const Color(0xFF40AA54)) {
            color = Colors.white;
            image = "${rootImagePath}logo2.png";
          } else {
            color = const Color(0xFF40AA54);
            image = "${rootImagePath}logo1.png";
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      body: Center(child: Image.asset(image, height: 70, width: 280)),
    );
  }
}

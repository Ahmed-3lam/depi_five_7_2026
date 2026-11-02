import 'dart:async';
import 'package:depi_five/core/services/remote_config_service.dart';
import 'package:depi_five/core/widgets/force_update_dialog.dart';
import 'package:depi_five/core/helpers/hive_helper.dart';
import 'package:depi_five/features/auth/view/pages/base_auth_page.dart';
import 'package:depi_five/features/home/view/home_page.dart';
import 'package:depi_five/features/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/const/image_paths.dart' show rootImagePath;

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, this.checkForUpdate});

  final Future<AppUpdateRequirement?> Function()? checkForUpdate;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var color = Color(0xFF40AA54);
  var image = "assets/images/logo1.png";
  Timer? _countdownTimer;
  late final Future<AppUpdateRequirement?> _updateCheck;

  @override
  void initState() {
    super.initState();
    _updateCheck = _checkForUpdate();
    _startCountdown();
  }

  Future<AppUpdateRequirement?> _checkForUpdate() =>
      (widget.checkForUpdate ?? RemoteConfigService.instance.checkForUpdate)();

  Future<void> _finishSplash() async {
    var requirement = await _updateCheck;
    if (!mounted) return;
    while (requirement != null && mounted) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => ForceUpdateDialog(
          requirement: requirement!,
          onCheckAgain: () async {
            final updatedRequirement = await _checkForUpdate();
            if (!mounted || !dialogContext.mounted) return;
            requirement = updatedRequirement;
            Navigator.of(dialogContext).pop();
          },
        ),
      );
    }
    if (!mounted) return;
    if (HiveHelper.getToken()) {
      Get.offAll(() => const HomePage());
    } else if (HiveHelper.isOnboardingSeen()) {
      Get.offAll(() => const BaseAuthPage());
    } else {
      Get.offAll(() => const OnboardingPage());
    }
  }

  void _startCountdown() {
    int counter = 2;

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      counter--;

      if (counter == 0) {
        timer.cancel();
        unawaited(_finishSplash());
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

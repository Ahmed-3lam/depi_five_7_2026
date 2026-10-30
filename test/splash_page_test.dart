import 'dart:io';

import 'package:depi_five/core/helpers/hive_helper.dart';
import 'package:depi_five/features/home/view/home_page.dart';
import 'package:depi_five/features/onboarding/onboarding_page.dart';
import 'package:depi_five/features/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

void main() {
  late Directory storage;

  setUp(() async {
    Get.testMode = true;
    storage = await Directory.systemTemp.createTemp('splash_test_');
    Hive.init(storage.path);
    await Hive.openBox(HiveHelper.tokenBox);
    await Hive.openBox(HiveHelper.onBoardingBox);
  });

  tearDown(() async {
    Get.reset();
    await Hive.close();
    await storage.delete(recursive: true);
  });

  for (final onboardingSeen in [false, true]) {
    testWidgets(
      'saved token opens home without onboarding (seen: $onboardingSeen)',
      (tester) async {
        await tester.runAsync(() async {
          await Hive.box(HiveHelper.tokenBox).put(HiveHelper.tokenBox, 'token');
          if (onboardingSeen) {
            await Hive.box(
              HiveHelper.onBoardingBox,
            ).put(HiveHelper.onBoardingBox, true);
          }
        });

        await tester.pumpWidget(const GetMaterialApp(home: SplashPage()));
        await tester.pump(const Duration(seconds: 1));

        expect(find.byType(SplashPage), findsOneWidget);
        expect(find.byType(OnboardingPage), findsNothing);
        expect(find.byType(HomePage), findsNothing);

        await tester.pump(const Duration(seconds: 1));
        await tester.pumpAndSettle();

        expect(find.byType(HomePage), findsOneWidget);
        expect(find.byType(OnboardingPage), findsNothing);
      },
    );
  }

  testWidgets('new user opens onboarding after the splash', (tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const GetMaterialApp(home: SplashPage()));
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(OnboardingPage), findsNothing);

    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    expect(find.byType(OnboardingPage), findsOneWidget);
    expect(find.byType(HomePage), findsNothing);
  });

  testWidgets('removing splash cancels pending navigation', (tester) async {
    await tester.pumpWidget(const GetMaterialApp(home: SplashPage()));
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 3));

    expect(tester.takeException(), isNull);
    expect(find.byType(OnboardingPage), findsNothing);
    expect(find.byType(HomePage), findsNothing);
  });
}

import 'package:hive/hive.dart';

class HiveHelper {
  ///Box
  static const onBoardingBox = "onBoardingBox";

  ///Methods

  static void saveOnboardingEntry() async {
    await Hive.box(onBoardingBox).put(onBoardingBox, true);
  }

  static bool isOnboardingSeen() {
    if (Hive.box(onBoardingBox).get(onBoardingBox) != null) {
      return true;
    } else {
      return false;
    }
  }
}

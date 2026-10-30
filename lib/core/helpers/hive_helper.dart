import 'package:hive/hive.dart';

class HiveHelper {
  ///Box
  static const onBoardingBox = "onBoardingBox";
  static const tokenBox = "tokenBox";

  ///Methods

  static void setToken(String token) async {
    await Hive.box(tokenBox).put(tokenBox, token);
  }

  static bool getToken()  {
    if (Hive.box(tokenBox).isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

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

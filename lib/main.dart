import 'dart:ui';

import 'package:depi_five/config/bloc_observer.dart';
import 'package:depi_five/core/helpers/hive_helper.dart';
import 'package:depi_five/features/auth/cubit/cubit/auth_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'core/helpers/network/network_helper.dart';
import 'features/home/cubit/cubit/home_cubit.dart';
import 'features/splash/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
Bloc.observer = AppBlocObserver();
  await Hive.initFlutter();
  await Hive.openBox(HiveHelper.onBoardingBox);
  await Hive.openBox(HiveHelper.tokenBox);
  NetworkHelper.initializeDio();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => HomeCubit()..fetchBanners()..fetchProducts()),
      ],
      child: GetMaterialApp(home: SplashPage()),
    );
  }
}

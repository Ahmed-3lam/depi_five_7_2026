import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';

class AppUpdateRequirement {
  const AppUpdateRequirement({
    required this.currentVersion,
    required this.minimumVersion,
  });

  final String currentVersion;
  final String minimumVersion;
}

class RemoteConfigService {
  RemoteConfigService({
    FirebaseRemoteConfig? remoteConfig,
    Future<PackageInfo> Function()? packageInfoLoader,
  }) : _remoteConfig = remoteConfig,
       _packageInfoLoader = packageInfoLoader ?? PackageInfo.fromPlatform;

  static final instance = RemoteConfigService();
  static const forceUpdateKey = 'force_update';
  static const minAppVersionKey = 'min_app_version';

  FirebaseRemoteConfig? _remoteConfig;
  final Future<PackageInfo> Function() _packageInfoLoader;

  /// Fetch failures retain the last activated policy; first launches use defaults.
  Future<AppUpdateRequirement?> checkForUpdate() async {
    try {
      final config = _remoteConfig ??= FirebaseRemoteConfig.instance;
      await config.setDefaults({
        forceUpdateKey: false,
        minAppVersionKey: '1.0.0',
      });
      await config.ensureInitialized();
      try {
        await config.setConfigSettings(
          RemoteConfigSettings(
            fetchTimeout: const Duration(seconds: 10),
            minimumFetchInterval: kDebugMode
                ? Duration.zero
                : const Duration(hours: 1),
          ),
        );
        await config.fetchAndActivate();
      } catch (error) {
        debugPrint('Remote Config fetch failed; using cached values: $error');
      }

      final currentVersion = (await _packageInfoLoader()).version; //1.0.0
      final minimumVersion = config.getString(minAppVersionKey).trim();
      if (requiresUpdate(
        forceUpdate: config.getBool(forceUpdateKey),
        currentVersion: currentVersion,
        minimumVersion: minimumVersion,
      )) {
        return AppUpdateRequirement(
          currentVersion: currentVersion,
          minimumVersion: minimumVersion,
        );
      }
    } catch (error) {
      debugPrint('Unable to check the app update policy: $error');
    }
    return null;
  }

  static bool requiresUpdate({
    required bool forceUpdate,
    required String currentVersion,
    required String minimumVersion,
  }) {
    if (!forceUpdate) return false;
    try {
      // Compare semantic versions numerically, ignoring build numbers (+123).
      final current = Version.parse(currentVersion.trim().split('+').first);
      final minimum = Version.parse(minimumVersion.trim().split('+').first);
      return current < minimum;
    } on FormatException {
      // A malformed console value must not lock users out.
      return false;
    }
  }
}

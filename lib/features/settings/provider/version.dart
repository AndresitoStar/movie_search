import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'version.g.dart';

/// Model to hold app version information
class AppVersionInfo {
  final String version;
  final String buildNumber;
  final String appName;
  final String packageName;

  AppVersionInfo({required this.version, required this.buildNumber, required this.appName, required this.packageName});

  /// Returns formatted version string (e.g., "2.0.0+1")
  String get fullVersion => '$version+$buildNumber';

  /// Returns version with build number (e.g., "2.0.0 (1)")
  String get versionWithBuild => '$version ($buildNumber)';
}

@Riverpod(keepAlive: true)
class AppVersion extends _$AppVersion {
  @override
  Future<AppVersionInfo> build() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return AppVersionInfo(
      version: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
      appName: packageInfo.appName,
      packageName: packageInfo.packageName,
    );
  }
}

/// Provider to get the version string (e.g., "2.0.0")
@riverpod
String appVersionString(ref) {
  final versionInfo = ref.watch(appVersionProvider);
  return versionInfo.when(data: (info) => info.version, loading: () => '...', error: (_, __) => 'Unknown');
}

/// Provider to get the full version with build number (e.g., "2.0.0+1")
@riverpod
String appFullVersion(ref) {
  final versionInfo = ref.watch(appVersionProvider);
  return versionInfo.when(data: (info) => info.fullVersion, loading: () => '...', error: (_, __) => 'Unknown');
}

/// Provider to get the version with build in parentheses (e.g., "2.0.0 (1)")
@riverpod
String appVersionWithBuild(ref) {
  final versionInfo = ref.watch(appVersionProvider);
  return versionInfo.when(data: (info) => info.versionWithBuild, loading: () => '...', error: (_, __) => 'Unknown');
}

/// Provider to get the app name
@riverpod
String appName(ref) {
  final versionInfo = ref.watch(appVersionProvider);
  return versionInfo.when(data: (info) => info.appName, loading: () => '...', error: (_, __) => 'Unknown');
}

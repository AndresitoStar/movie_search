// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppVersion)
final appVersionProvider = AppVersionProvider._();

final class AppVersionProvider
    extends $AsyncNotifierProvider<AppVersion, AppVersionInfo> {
  AppVersionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appVersionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appVersionHash();

  @$internal
  @override
  AppVersion create() => AppVersion();
}

String _$appVersionHash() => r'c6a24bdde5b7a4fe6b0c3d0d682eec3451664a0d';

abstract class _$AppVersion extends $AsyncNotifier<AppVersionInfo> {
  FutureOr<AppVersionInfo> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AppVersionInfo>, AppVersionInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppVersionInfo>, AppVersionInfo>,
              AsyncValue<AppVersionInfo>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Provider to get the version string (e.g., "2.0.0")

@ProviderFor(appVersionString)
final appVersionStringProvider = AppVersionStringProvider._();

/// Provider to get the version string (e.g., "2.0.0")

final class AppVersionStringProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// Provider to get the version string (e.g., "2.0.0")
  AppVersionStringProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appVersionStringProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appVersionStringHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return appVersionString(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$appVersionStringHash() => r'f36cd6ee334f6500c5f677000bd098b8c295e702';

/// Provider to get the full version with build number (e.g., "2.0.0+1")

@ProviderFor(appFullVersion)
final appFullVersionProvider = AppFullVersionProvider._();

/// Provider to get the full version with build number (e.g., "2.0.0+1")

final class AppFullVersionProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// Provider to get the full version with build number (e.g., "2.0.0+1")
  AppFullVersionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appFullVersionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appFullVersionHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return appFullVersion(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$appFullVersionHash() => r'a3ea47c979b0cc7653bd6e195a727d0e433783c2';

/// Provider to get the version with build in parentheses (e.g., "2.0.0 (1)")

@ProviderFor(appVersionWithBuild)
final appVersionWithBuildProvider = AppVersionWithBuildProvider._();

/// Provider to get the version with build in parentheses (e.g., "2.0.0 (1)")

final class AppVersionWithBuildProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// Provider to get the version with build in parentheses (e.g., "2.0.0 (1)")
  AppVersionWithBuildProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appVersionWithBuildProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appVersionWithBuildHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return appVersionWithBuild(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$appVersionWithBuildHash() =>
    r'3ffc996517706aa0114d98953dcd93a562509b58';

/// Provider to get the app name

@ProviderFor(appName)
final appNameProvider = AppNameProvider._();

/// Provider to get the app name

final class AppNameProvider extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// Provider to get the app name
  AppNameProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appNameProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appNameHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return appName(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$appNameHash() => r'3faa4fdad019de1410f43b1f47dd90a4b1dc950c';

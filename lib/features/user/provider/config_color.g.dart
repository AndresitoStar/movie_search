// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_color.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ColorConfig)
const colorConfigProvider = ColorConfigProvider._();

final class ColorConfigProvider
    extends $AsyncNotifierProvider<ColorConfig, FlexScheme> {
  const ColorConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'colorConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$colorConfigHash();

  @$internal
  @override
  ColorConfig create() => ColorConfig();
}

String _$colorConfigHash() => r'c649033bdb01ac7b199cc1d768509d123e9d582a';

abstract class _$ColorConfig extends $AsyncNotifier<FlexScheme> {
  FutureOr<FlexScheme> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<FlexScheme>, FlexScheme>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<FlexScheme>, FlexScheme>,
              AsyncValue<FlexScheme>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider to get the current color scheme

@ProviderFor(currentColorScheme)
const currentColorSchemeProvider = CurrentColorSchemeProvider._();

/// Provider to get the current color scheme

final class CurrentColorSchemeProvider
    extends $FunctionalProvider<FlexScheme, FlexScheme, FlexScheme>
    with $Provider<FlexScheme> {
  /// Provider to get the current color scheme
  const CurrentColorSchemeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentColorSchemeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentColorSchemeHash();

  @$internal
  @override
  $ProviderElement<FlexScheme> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FlexScheme create(Ref ref) {
    return currentColorScheme(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlexScheme value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlexScheme>(value),
    );
  }
}

String _$currentColorSchemeHash() =>
    r'0a2f09508505b23718861c73d4aea19f8f9418ce';

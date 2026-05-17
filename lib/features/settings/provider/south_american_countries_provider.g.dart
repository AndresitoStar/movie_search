// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'south_american_countries_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SouthAmericanCountries)
final southAmericanCountriesProvider = SouthAmericanCountriesProvider._();

final class SouthAmericanCountriesProvider
    extends $AsyncNotifierProvider<SouthAmericanCountries, List<Country>> {
  SouthAmericanCountriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'southAmericanCountriesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$southAmericanCountriesHash();

  @$internal
  @override
  SouthAmericanCountries create() => SouthAmericanCountries();
}

String _$southAmericanCountriesHash() =>
    r'e02698ff5adb87ee012541bb0b38bac7dc22124b';

abstract class _$SouthAmericanCountries extends $AsyncNotifier<List<Country>> {
  FutureOr<List<Country>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Country>>, List<Country>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Country>>, List<Country>>,
              AsyncValue<List<Country>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SelectedCountry)
final selectedCountryProvider = SelectedCountryProvider._();

final class SelectedCountryProvider
    extends $AsyncNotifierProvider<SelectedCountry, Country> {
  SelectedCountryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedCountryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedCountryHash();

  @$internal
  @override
  SelectedCountry create() => SelectedCountry();
}

String _$selectedCountryHash() => r'2faf3c1d065e778847287af19d23b357c719d81c';

abstract class _$SelectedCountry extends $AsyncNotifier<Country> {
  FutureOr<Country> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Country>, Country>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Country>, Country>,
              AsyncValue<Country>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

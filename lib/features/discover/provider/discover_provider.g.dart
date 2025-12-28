// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discover_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Discover)
const discoverProvider = DiscoverProvider._();

final class DiscoverProvider
    extends $NotifierProvider<Discover, PaginatedState> {
  const DiscoverProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discoverProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discoverHash();

  @$internal
  @override
  Discover create() => Discover();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaginatedState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PaginatedState>(value),
    );
  }
}

String _$discoverHash() => r'a8ee198ebaef0f2c6729adcd16b7abfebf50b949';

abstract class _$Discover extends $Notifier<PaginatedState> {
  PaginatedState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PaginatedState, PaginatedState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PaginatedState, PaginatedState>,
              PaginatedState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(DiscoverFilter)
const discoverFilterProvider = DiscoverFilterProvider._();

final class DiscoverFilterProvider
    extends $NotifierProvider<DiscoverFilter, DiscoverFilterState> {
  const DiscoverFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discoverFilterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discoverFilterHash();

  @$internal
  @override
  DiscoverFilter create() => DiscoverFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DiscoverFilterState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DiscoverFilterState>(value),
    );
  }
}

String _$discoverFilterHash() => r'54745f51801017c8580ae14b834bf8e9b13a87d3';

abstract class _$DiscoverFilter extends $Notifier<DiscoverFilterState> {
  DiscoverFilterState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DiscoverFilterState, DiscoverFilterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DiscoverFilterState, DiscoverFilterState>,
              DiscoverFilterState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discover_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Discover)
final discoverProvider = DiscoverProvider._();

final class DiscoverProvider
    extends $NotifierProvider<Discover, PaginatedState> {
  DiscoverProvider._()
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

String _$discoverHash() => r'9712474934e30613a1f71a627b829258f525d45f';

abstract class _$Discover extends $Notifier<PaginatedState> {
  PaginatedState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PaginatedState, PaginatedState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PaginatedState, PaginatedState>,
              PaginatedState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(DiscoverFilter)
final discoverFilterProvider = DiscoverFilterProvider._();

final class DiscoverFilterProvider
    extends $NotifierProvider<DiscoverFilter, DiscoverFilterState> {
  DiscoverFilterProvider._()
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

String _$discoverFilterHash() => r'5791f93361ffe17ff6396347dad06080d1d3c621';

abstract class _$DiscoverFilter extends $Notifier<DiscoverFilterState> {
  DiscoverFilterState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DiscoverFilterState, DiscoverFilterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DiscoverFilterState, DiscoverFilterState>,
              DiscoverFilterState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

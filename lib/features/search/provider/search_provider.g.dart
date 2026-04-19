// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Search)
final searchProvider = SearchProvider._();

final class SearchProvider
    extends $NotifierProvider<Search, SearchPaginatedState> {
  SearchProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchHash();

  @$internal
  @override
  Search create() => Search();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchPaginatedState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchPaginatedState>(value),
    );
  }
}

String _$searchHash() => r'd5cd165440b33f5c89efea9c9893199088159b0c';

abstract class _$Search extends $Notifier<SearchPaginatedState> {
  SearchPaginatedState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SearchPaginatedState, SearchPaginatedState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SearchPaginatedState, SearchPaginatedState>,
              SearchPaginatedState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SearchSelectedIndex)
final searchSelectedIndexProvider = SearchSelectedIndexProvider._();

final class SearchSelectedIndexProvider
    extends $NotifierProvider<SearchSelectedIndex, num> {
  SearchSelectedIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchSelectedIndexProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchSelectedIndexHash();

  @$internal
  @override
  SearchSelectedIndex create() => SearchSelectedIndex();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(num value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<num>(value),
    );
  }
}

String _$searchSelectedIndexHash() =>
    r'c39f47d5a402981918dc20fbfce61ac65cf09902';

abstract class _$SearchSelectedIndex extends $Notifier<num> {
  num build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<num, num>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<num, num>,
              num,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

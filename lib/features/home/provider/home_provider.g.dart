// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeContentType)
const homeContentTypeProvider = HomeContentTypeProvider._();

final class HomeContentTypeProvider
    extends $AsyncNotifierProvider<HomeContentType, TMDB_API_TYPE> {
  const HomeContentTypeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeContentTypeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeContentTypeHash();

  @$internal
  @override
  HomeContentType create() => HomeContentType();
}

String _$homeContentTypeHash() => r'9ef48401010f0dcfa4ed2b8751dca87eb5d6971c';

abstract class _$HomeContentType extends $AsyncNotifier<TMDB_API_TYPE> {
  FutureOr<TMDB_API_TYPE> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<TMDB_API_TYPE>, TMDB_API_TYPE>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TMDB_API_TYPE>, TMDB_API_TYPE>,
              AsyncValue<TMDB_API_TYPE>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(HomeGenreCarouseSelected)
const homeGenreCarouseSelectedProvider = HomeGenreCarouseSelectedProvider._();

final class HomeGenreCarouseSelectedProvider
    extends $NotifierProvider<HomeGenreCarouseSelected, Genre?> {
  const HomeGenreCarouseSelectedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeGenreCarouseSelectedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeGenreCarouseSelectedHash();

  @$internal
  @override
  HomeGenreCarouseSelected create() => HomeGenreCarouseSelected();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Genre? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Genre?>(value),
    );
  }
}

String _$homeGenreCarouseSelectedHash() =>
    r'0f1664af2ff64501ec5a65eacb1e6995c21f8831';

abstract class _$HomeGenreCarouseSelected extends $Notifier<Genre?> {
  Genre? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Genre?, Genre?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Genre?, Genre?>,
              Genre?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(itemsForActualGenre)
const itemsForActualGenreProvider = ItemsForActualGenreProvider._();

final class ItemsForActualGenreProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BaseSearchResult>>,
          List<BaseSearchResult>,
          FutureOr<List<BaseSearchResult>>
        >
    with
        $FutureModifier<List<BaseSearchResult>>,
        $FutureProvider<List<BaseSearchResult>> {
  const ItemsForActualGenreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'itemsForActualGenreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$itemsForActualGenreHash();

  @$internal
  @override
  $FutureProviderElement<List<BaseSearchResult>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BaseSearchResult>> create(Ref ref) {
    return itemsForActualGenre(ref);
  }
}

String _$itemsForActualGenreHash() =>
    r'd556d8de0a22a457c9624a66379415d5b7a82c08';

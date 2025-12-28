// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'infinite_scroll_content_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fetchBaseContent)
const fetchBaseContentProvider = FetchBaseContentFamily._();

final class FetchBaseContentProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BaseSearchResult>>,
          List<BaseSearchResult>,
          FutureOr<List<BaseSearchResult>>
        >
    with
        $FutureModifier<List<BaseSearchResult>>,
        $FutureProvider<List<BaseSearchResult>> {
  const FetchBaseContentProvider._({
    required FetchBaseContentFamily super.from,
    required (ContentConfig, TMDB_API_TYPE?, Map<ApiParams, String>)
    super.argument,
  }) : super(
         retry: null,
         name: r'fetchBaseContentProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchBaseContentHash();

  @override
  String toString() {
    return r'fetchBaseContentProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<BaseSearchResult>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BaseSearchResult>> create(Ref ref) {
    final argument =
        this.argument
            as (ContentConfig, TMDB_API_TYPE?, Map<ApiParams, String>);
    return fetchBaseContent(ref, argument.$1, argument.$2, argument.$3);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchBaseContentProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchBaseContentHash() => r'8cf67e2e7b5597d48881c185f216e5712799f57d';

final class FetchBaseContentFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<BaseSearchResult>>,
          (ContentConfig, TMDB_API_TYPE?, Map<ApiParams, String>)
        > {
  const FetchBaseContentFamily._()
    : super(
        retry: null,
        name: r'fetchBaseContentProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchBaseContentProvider call(
    ContentConfig apiPath,
    TMDB_API_TYPE? requiredType,
    Map<ApiParams, String> params,
  ) => FetchBaseContentProvider._(
    argument: (apiPath, requiredType, params),
    from: this,
  );

  @override
  String toString() => r'fetchBaseContentProvider';
}

@ProviderFor(ContentPreviewListItems)
const contentPreviewListItemsProvider = ContentPreviewListItemsFamily._();

final class ContentPreviewListItemsProvider
    extends $NotifierProvider<ContentPreviewListItems, PaginatedState> {
  const ContentPreviewListItemsProvider._({
    required ContentPreviewListItemsFamily super.from,
    required (ContentConfig, TMDB_API_TYPE?, Map<ApiParams, String>)
    super.argument,
  }) : super(
         retry: null,
         name: r'contentPreviewListItemsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$contentPreviewListItemsHash();

  @override
  String toString() {
    return r'contentPreviewListItemsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  ContentPreviewListItems create() => ContentPreviewListItems();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaginatedState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PaginatedState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ContentPreviewListItemsProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$contentPreviewListItemsHash() =>
    r'65c994feb70ab0f3bedc854675bfb9b0579fa623';

final class ContentPreviewListItemsFamily extends $Family
    with
        $ClassFamilyOverride<
          ContentPreviewListItems,
          PaginatedState,
          PaginatedState,
          PaginatedState,
          (ContentConfig, TMDB_API_TYPE?, Map<ApiParams, String>)
        > {
  const ContentPreviewListItemsFamily._()
    : super(
        retry: null,
        name: r'contentPreviewListItemsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ContentPreviewListItemsProvider call(
    ContentConfig apiPath,
    TMDB_API_TYPE? requiredType,
    Map<ApiParams, String> params,
  ) => ContentPreviewListItemsProvider._(
    argument: (apiPath, requiredType, params),
    from: this,
  );

  @override
  String toString() => r'contentPreviewListItemsProvider';
}

abstract class _$ContentPreviewListItems extends $Notifier<PaginatedState> {
  late final _$args =
      ref.$arg as (ContentConfig, TMDB_API_TYPE?, Map<ApiParams, String>);
  ContentConfig get apiPath => _$args.$1;
  TMDB_API_TYPE? get requiredType => _$args.$2;
  Map<ApiParams, String> get params => _$args.$3;

  PaginatedState build(
    ContentConfig apiPath,
    TMDB_API_TYPE? requiredType,
    Map<ApiParams, String> params,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args.$1, _$args.$2, _$args.$3);
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

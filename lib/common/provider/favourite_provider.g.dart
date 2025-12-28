// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FavouriteList)
const favouriteListProvider = FavouriteListProvider._();

final class FavouriteListProvider
    extends
        $AsyncNotifierProvider<
          FavouriteList,
          Map<String, List<BaseSearchResult>>
        > {
  const FavouriteListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favouriteListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favouriteListHash();

  @$internal
  @override
  FavouriteList create() => FavouriteList();
}

String _$favouriteListHash() => r'0c6b71c69e7da0f6ad6524a8c4eda5e44fb3f015';

abstract class _$FavouriteList
    extends $AsyncNotifier<Map<String, List<BaseSearchResult>>> {
  FutureOr<Map<String, List<BaseSearchResult>>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<Map<String, List<BaseSearchResult>>>,
              Map<String, List<BaseSearchResult>>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, List<BaseSearchResult>>>,
                Map<String, List<BaseSearchResult>>
              >,
              AsyncValue<Map<String, List<BaseSearchResult>>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(bookmarks)
const bookmarksProvider = BookmarksFamily._();

final class BookmarksProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  const BookmarksProvider._({
    required BookmarksFamily super.from,
    required num super.argument,
  }) : super(
         retry: null,
         name: r'bookmarksProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$bookmarksHash();

  @override
  String toString() {
    return r'bookmarksProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    final argument = this.argument as num;
    return bookmarks(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is BookmarksProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bookmarksHash() => r'497ec761f80af78e0ded5248ad6c08d5269c44c2';

final class BookmarksFamily extends $Family
    with $FunctionalFamilyOverride<String?, num> {
  const BookmarksFamily._()
    : super(
        retry: null,
        name: r'bookmarksProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  BookmarksProvider call(num id) =>
      BookmarksProvider._(argument: id, from: this);

  @override
  String toString() => r'bookmarksProvider';
}

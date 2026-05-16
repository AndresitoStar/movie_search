// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audiovisual_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fetchDetails)
final fetchDetailsProvider = FetchDetailsFamily._();

final class FetchDetailsProvider
    extends
        $FunctionalProvider<
          AsyncValue<BaseSearchResult>,
          BaseSearchResult,
          FutureOr<BaseSearchResult>
        >
    with $FutureModifier<BaseSearchResult>, $FutureProvider<BaseSearchResult> {
  FetchDetailsProvider._({
    required FetchDetailsFamily super.from,
    required (num, String) super.argument,
  }) : super(
         retry: null,
         name: r'fetchDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchDetailsHash();

  @override
  String toString() {
    return r'fetchDetailsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<BaseSearchResult> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BaseSearchResult> create(Ref ref) {
    final argument = this.argument as (num, String);
    return fetchDetails(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchDetailsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchDetailsHash() => r'7ed0d616cf39ae692856f40671a4fba4e76aa1a2';

final class FetchDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<BaseSearchResult>, (num, String)> {
  FetchDetailsFamily._()
    : super(
        retry: null,
        name: r'fetchDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchDetailsProvider call(num id, String type) =>
      FetchDetailsProvider._(argument: (id, type), from: this);

  @override
  String toString() => r'fetchDetailsProvider';
}

@ProviderFor(fetchImages)
final fetchImagesProvider = FetchImagesFamily._();

final class FetchImagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<MediaImageResponse>,
          MediaImageResponse,
          FutureOr<MediaImageResponse>
        >
    with
        $FutureModifier<MediaImageResponse>,
        $FutureProvider<MediaImageResponse> {
  FetchImagesProvider._({
    required FetchImagesFamily super.from,
    required (num, String) super.argument,
  }) : super(
         retry: null,
         name: r'fetchImagesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchImagesHash();

  @override
  String toString() {
    return r'fetchImagesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<MediaImageResponse> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MediaImageResponse> create(Ref ref) {
    final argument = this.argument as (num, String);
    return fetchImages(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchImagesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchImagesHash() => r'3ba48aee403d37f14001e87905dba018c29d684d';

final class FetchImagesFamily extends $Family
    with
        $FunctionalFamilyOverride<FutureOr<MediaImageResponse>, (num, String)> {
  FetchImagesFamily._()
    : super(
        retry: null,
        name: r'fetchImagesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchImagesProvider call(num id, String type) =>
      FetchImagesProvider._(argument: (id, type), from: this);

  @override
  String toString() => r'fetchImagesProvider';
}

@ProviderFor(fetchImdbRating)
final fetchImdbRatingProvider = FetchImdbRatingFamily._();

final class FetchImdbRatingProvider
    extends $FunctionalProvider<AsyncValue<num>, num, FutureOr<num>>
    with $FutureModifier<num>, $FutureProvider<num> {
  FetchImdbRatingProvider._({
    required FetchImdbRatingFamily super.from,
    required (num, String, String?) super.argument,
  }) : super(
         retry: null,
         name: r'fetchImdbRatingProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchImdbRatingHash();

  @override
  String toString() {
    return r'fetchImdbRatingProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<num> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<num> create(Ref ref) {
    final argument = this.argument as (num, String, String?);
    return fetchImdbRating(ref, argument.$1, argument.$2, argument.$3);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchImdbRatingProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchImdbRatingHash() => r'8197a8c355a534a03934bd4aac9a6a7ed023f98a';

final class FetchImdbRatingFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<num>, (num, String, String?)> {
  FetchImdbRatingFamily._()
    : super(
        retry: null,
        name: r'fetchImdbRatingProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchImdbRatingProvider call(num id, String type, String? imdbId) =>
      FetchImdbRatingProvider._(argument: (id, type, imdbId), from: this);

  @override
  String toString() => r'fetchImdbRatingProvider';
}

@ProviderFor(fetchContentRatings)
final fetchContentRatingsProvider = FetchContentRatingsFamily._();

final class FetchContentRatingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<ContentRatings>,
          ContentRatings,
          FutureOr<ContentRatings>
        >
    with $FutureModifier<ContentRatings>, $FutureProvider<ContentRatings> {
  FetchContentRatingsProvider._({
    required FetchContentRatingsFamily super.from,
    required (num, String) super.argument,
  }) : super(
         retry: null,
         name: r'fetchContentRatingsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchContentRatingsHash();

  @override
  String toString() {
    return r'fetchContentRatingsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<ContentRatings> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ContentRatings> create(Ref ref) {
    final argument = this.argument as (num, String);
    return fetchContentRatings(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchContentRatingsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchContentRatingsHash() =>
    r'7d9353d16a8cdedd77f8d191d774bca5d03d1725';

final class FetchContentRatingsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ContentRatings>, (num, String)> {
  FetchContentRatingsFamily._()
    : super(
        retry: null,
        name: r'fetchContentRatingsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchContentRatingsProvider call(num id, String type) =>
      FetchContentRatingsProvider._(argument: (id, type), from: this);

  @override
  String toString() => r'fetchContentRatingsProvider';
}

@ProviderFor(fetchVideos)
final fetchVideosProvider = FetchVideosFamily._();

final class FetchVideosProvider
    extends $FunctionalProvider<AsyncValue<Videos>, Videos, FutureOr<Videos>>
    with $FutureModifier<Videos>, $FutureProvider<Videos> {
  FetchVideosProvider._({
    required FetchVideosFamily super.from,
    required (num, String) super.argument,
  }) : super(
         retry: null,
         name: r'fetchVideosProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchVideosHash();

  @override
  String toString() {
    return r'fetchVideosProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Videos> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Videos> create(Ref ref) {
    final argument = this.argument as (num, String);
    return fetchVideos(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchVideosProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchVideosHash() => r'82b3494a1640ecfb1faef5f17046eb27c9eea85b';

final class FetchVideosFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Videos>, (num, String)> {
  FetchVideosFamily._()
    : super(
        retry: null,
        name: r'fetchVideosProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchVideosProvider call(num id, String type) =>
      FetchVideosProvider._(argument: (id, type), from: this);

  @override
  String toString() => r'fetchVideosProvider';
}

@ProviderFor(fetchCollectionDetails)
final fetchCollectionDetailsProvider = FetchCollectionDetailsFamily._();

final class FetchCollectionDetailsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Collection>,
          Collection,
          FutureOr<Collection>
        >
    with $FutureModifier<Collection>, $FutureProvider<Collection> {
  FetchCollectionDetailsProvider._({
    required FetchCollectionDetailsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'fetchCollectionDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchCollectionDetailsHash();

  @override
  String toString() {
    return r'fetchCollectionDetailsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Collection> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Collection> create(Ref ref) {
    final argument = this.argument as String;
    return fetchCollectionDetails(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchCollectionDetailsProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchCollectionDetailsHash() =>
    r'346966f790e8a8c6140887381d2ec628879f30ed';

final class FetchCollectionDetailsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Collection>, String> {
  FetchCollectionDetailsFamily._()
    : super(
        retry: null,
        name: r'fetchCollectionDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchCollectionDetailsProvider call(String id) =>
      FetchCollectionDetailsProvider._(argument: id, from: this);

  @override
  String toString() => r'fetchCollectionDetailsProvider';
}

@ProviderFor(fetchWatchProvider)
final fetchWatchProviderProvider = FetchWatchProviderFamily._();

final class FetchWatchProviderProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WatchProvider>>,
          List<WatchProvider>,
          FutureOr<List<WatchProvider>>
        >
    with
        $FutureModifier<List<WatchProvider>>,
        $FutureProvider<List<WatchProvider>> {
  FetchWatchProviderProvider._({
    required FetchWatchProviderFamily super.from,
    required (num, String) super.argument,
  }) : super(
         retry: null,
         name: r'fetchWatchProviderProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchWatchProviderHash();

  @override
  String toString() {
    return r'fetchWatchProviderProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<WatchProvider>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<WatchProvider>> create(Ref ref) {
    final argument = this.argument as (num, String);
    return fetchWatchProvider(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchWatchProviderProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchWatchProviderHash() =>
    r'862548e5f5d01edfaade4c9b5bcc9e41cf334e4d';

final class FetchWatchProviderFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<WatchProvider>>,
          (num, String)
        > {
  FetchWatchProviderFamily._()
    : super(
        retry: null,
        name: r'fetchWatchProviderProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchWatchProviderProvider call(num id, String type) =>
      FetchWatchProviderProvider._(argument: (id, type), from: this);

  @override
  String toString() => r'fetchWatchProviderProvider';
}

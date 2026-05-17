// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genres_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(genresByType)
final genresByTypeProvider = GenresByTypeFamily._();

final class GenresByTypeProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Genre>>,
          List<Genre>,
          FutureOr<List<Genre>>
        >
    with $FutureModifier<List<Genre>>, $FutureProvider<List<Genre>> {
  GenresByTypeProvider._({
    required GenresByTypeFamily super.from,
    required TMDB_API_TYPE super.argument,
  }) : super(
         retry: null,
         name: r'genresByTypeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$genresByTypeHash();

  @override
  String toString() {
    return r'genresByTypeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Genre>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Genre>> create(Ref ref) {
    final argument = this.argument as TMDB_API_TYPE;
    return genresByType(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GenresByTypeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$genresByTypeHash() => r'f280d0c583475d6eb598ec1d05294fb0a0d17033';

final class GenresByTypeFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Genre>>, TMDB_API_TYPE> {
  GenresByTypeFamily._()
    : super(
        retry: null,
        name: r'genresByTypeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GenresByTypeProvider call(TMDB_API_TYPE type) =>
      GenresByTypeProvider._(argument: type, from: this);

  @override
  String toString() => r'genresByTypeProvider';
}

@ProviderFor(watchProvidersByType)
final watchProvidersByTypeProvider = WatchProvidersByTypeFamily._();

final class WatchProvidersByTypeProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WatchProvider>>,
          List<WatchProvider>,
          FutureOr<List<WatchProvider>>
        >
    with
        $FutureModifier<List<WatchProvider>>,
        $FutureProvider<List<WatchProvider>> {
  WatchProvidersByTypeProvider._({
    required WatchProvidersByTypeFamily super.from,
    required TMDB_API_TYPE super.argument,
  }) : super(
         retry: null,
         name: r'watchProvidersByTypeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$watchProvidersByTypeHash();

  @override
  String toString() {
    return r'watchProvidersByTypeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<WatchProvider>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<WatchProvider>> create(Ref ref) {
    final argument = this.argument as TMDB_API_TYPE;
    return watchProvidersByType(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WatchProvidersByTypeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$watchProvidersByTypeHash() =>
    r'c7b68c045f5f6c190f70700e2746bec7471046f6';

final class WatchProvidersByTypeFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<WatchProvider>>,
          TMDB_API_TYPE
        > {
  WatchProvidersByTypeFamily._()
    : super(
        retry: null,
        name: r'watchProvidersByTypeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  WatchProvidersByTypeProvider call(TMDB_API_TYPE type) =>
      WatchProvidersByTypeProvider._(argument: type, from: this);

  @override
  String toString() => r'watchProvidersByTypeProvider';
}

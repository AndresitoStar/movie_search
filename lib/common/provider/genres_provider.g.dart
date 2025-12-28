// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genres_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(genresByType)
const genresByTypeProvider = GenresByTypeFamily._();

final class GenresByTypeProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Genre>>,
          List<Genre>,
          FutureOr<List<Genre>>
        >
    with $FutureModifier<List<Genre>>, $FutureProvider<List<Genre>> {
  const GenresByTypeProvider._({
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
  const GenresByTypeFamily._()
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

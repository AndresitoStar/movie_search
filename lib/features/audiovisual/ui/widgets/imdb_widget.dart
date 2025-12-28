import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/features/audiovisual/provider/audiovisual_provider.dart';

class ImdbRatingView extends ConsumerWidget {
  final String? imdbId;
  final num tmdbId;
  final String type;

  const ImdbRatingView(this.tmdbId, this.type, {super.key, required this.imdbId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rating = ref.watch(fetchImdbRatingProvider(tmdbId, type, imdbId));

    return Chip(
      // backgroundColor: Colors.transparent,
      avatar: Image.asset('assets/images/imdb.png', height: 34),
      onDeleted: rating.hasError ? () => ref.invalidate(fetchImdbRatingProvider(tmdbId, type, imdbId)) : null,
      deleteIcon: rating.isLoading
          ? CircularProgressIndicator(strokeWidth: 1)
          : rating.hasError
          ? Icon(Icons.refresh)
          : null,
      label: !rating.hasValue ? Text('') : Text(rating.value! >= 0 ? '${rating.value?.toStringAsFixed(1)}' : 'N/A'),
    );
  }
}

class ContentRatingView extends ConsumerWidget {
  final num id;
  final TMDB_API_TYPE type;

  const ContentRatingView(this.id, this.type, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(fetchContentRatingsProvider(id, type.type));
    if (model.hasError || !model.hasValue || model.value!.results.isEmpty) {
      return SizedBox.shrink();
    }

    return Chip(
      backgroundColor: Colors.transparent,
      onDeleted: model.hasError ? () => ref.invalidate(fetchContentRatingsProvider(id, type.type)) : null,
      deleteIcon: model.isLoading
          ? CircularProgressIndicator(strokeWidth: 1)
          : model.hasError
          ? Icon(Icons.refresh)
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(color: context.theme.dividerColor),
      ),
      label: Text(model.value!.results.first.rating ?? '-'),
    );
  }
}

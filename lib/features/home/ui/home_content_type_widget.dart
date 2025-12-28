import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/features/home/provider/home_provider.dart';

class ContentTypeWidget extends ConsumerWidget {
  const ContentTypeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentTypeProvider = ref.watch(homeContentTypeProvider);

    return contentTypeProvider.when(
      data: (contentType) => PopupMenuButton<TMDB_API_TYPE>(
        initialValue: contentType,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(contentType.nameSingular, style: context.textTheme.bodyLarge),
            Icon(Icons.arrow_drop_down, color: context.textTheme.bodyLarge?.color),
          ],
        ),
        onSelected: (TMDB_API_TYPE result) {
          ref.read(homeContentTypeProvider.notifier).updateCurrentType(result);
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<TMDB_API_TYPE>>[
          PopupMenuItem(value: TMDB_API_TYPE.MOVIE, child: Text(TMDB_API_TYPE.MOVIE.nameSingular)),
          PopupMenuItem(value: TMDB_API_TYPE.TV_SHOW, child: Text(TMDB_API_TYPE.TV_SHOW.nameSingular)),
        ],
      ),
      error: (error, stack) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
  }
}

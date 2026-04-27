import 'package:flutter/cupertino.dart';
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
      data: (contentType) => _buildContentTypeWidget(context, ref, contentType),
      error: (error, stack) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
  }

  Widget _buildContentTypeWidget(BuildContext context, WidgetRef ref, TMDB_API_TYPE contentType) {
    return CupertinoSegmentedControl<TMDB_API_TYPE>(
      groupValue: contentType,
      onValueChanged: (TMDB_API_TYPE value) {
        ref.read(homeContentTypeProvider.notifier).updateCurrentType(value);
      },
      selectedColor: context.theme.colorScheme.primary,
      unselectedColor: context.theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
      borderColor: context.theme.colorScheme.primary.withOpacity(0.3),
      pressedColor: context.theme.colorScheme.primary.withOpacity(0.2),
      padding: const EdgeInsets.all(4),
      children: {
        TMDB_API_TYPE.TV_SHOW: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            'Serie',
            style: context.textTheme.bodyMedium?.copyWith(
              color: contentType == TMDB_API_TYPE.TV_SHOW
                  ? context.theme.colorScheme.onPrimary
                  : context.textTheme.bodyMedium?.color,
              fontWeight: contentType == TMDB_API_TYPE.TV_SHOW ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        TMDB_API_TYPE.MOVIE: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            'Película',
            style: context.textTheme.bodyMedium?.copyWith(
              color: contentType == TMDB_API_TYPE.MOVIE
                  ? context.theme.colorScheme.onPrimary
                  : context.textTheme.bodyMedium?.color,
              fontWeight: contentType == TMDB_API_TYPE.MOVIE ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      },
    );
  }
}

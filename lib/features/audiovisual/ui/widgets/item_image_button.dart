import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/model/media_image.dart';
import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/common/ui/icons.dart';
import 'package:movie_search/features/audiovisual/provider/audiovisual_provider.dart';

class ItemImagesButtonView extends ConsumerWidget {
  final num id;
  final TMDB_API_TYPE type;
  final String title;
  final bool compact;

  const ItemImagesButtonView({
    super.key,
    required this.id,
    required this.title,
    required this.type,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagesProvider = ref.watch(fetchImagesProvider(id, type.type));
    return imagesProvider.when(
      loading: () => Padding(padding: const EdgeInsets.all(12.0), child: CircularProgressIndicator(strokeWidth: 1)),
      error: (error, stackTrace) => Container(),
      data: (data) => ShowImagesButton(images: data, title: title, compact: compact),
    );
  }
}

class ShowImagesButton extends StatelessWidget {
  final String title;
  final MediaImageResponse images;
  final bool compact;

  const ShowImagesButton({super.key, required this.title, required this.images, required this.compact});

  @override
  Widget build(BuildContext context) {
    final child = IconButton(
      onPressed: () => context.push('/images', extra: {'title': title, 'images': images.toMap()}),
      icon: Icon(MyIcons.gallery, color: Theme.of(context).colorScheme.onSurface),
    );
    return !compact
        ? child
        : InkWell(
            onTap: () {
              final imagesMap = images.toMap();
              if (imagesMap.length == 1) {
                final singleType = imagesMap.keys.first;
                final singleImages = imagesMap[singleType] ?? [];
                if (singleImages.isNotEmpty) {
                  context.push('/album', extra: {'type': singleType, 'images': singleImages});
                  return;
                }
              }
              context.push('/images', extra: {'title': title, 'images': images.toMap()});
            },
            splashColor: context.colors.secondary,
            focusColor: context.colors.secondary,
            overlayColor: WidgetStateProperty.all(context.colors.secondary.withOpacity(0.5)),
            child: Column(
              mainAxisSize: .min,
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              spacing: 1,
              children: [
                Icon(MyIcons.gallery, color: Theme.of(context).colorScheme.onSurface),
                Text('${images.totalImages} Images', style: Theme.of(context).textTheme.bodySmall, textAlign: .center),
              ],
            ),
          );
  }
}

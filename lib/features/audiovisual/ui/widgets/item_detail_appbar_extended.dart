import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/domain/search_result.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/common/ui/content_image.dart';
import 'package:movie_search/features/audiovisual/provider/audiovisual_provider.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/item_detail_content.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/item_image_button.dart';

class ItemDetailLandscapeAppBar extends StatelessWidget {
  final String heroTagPrefix;
  final bool isLandscape;
  final BaseSearchResult item;

  const ItemDetailLandscapeAppBar({
    super.key,
    required this.heroTagPrefix,
    this.isLandscape = false,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    if (!item.hasAnyImage()) {
      return Container(
        height: 200,
        alignment: Alignment.center,
        child: Text(
          'No images available',
          style: context.theme.textTheme.titleMedium!.copyWith(
            color: context.theme.textTheme.titleMedium!.color!.withOpacity(0.8),
          ),
        ),
      );
    }
    return Container(
      clipBehavior: .hardEdge,
      decoration: BoxDecoration(),
      child: AspectRatio(
        aspectRatio: 17.5 / 6,
        child: Row(
          spacing: 10,
          children: [
            SizedBox(width: 8),
            IgnorePointer(
              child: ContentImageWidget(item.posterImage, fit: BoxFit.fill),
            ),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: item.hasBackdrop()
                  ? IgnorePointer(
                      child: ContentImageWidget(item.backDropImage, fit: BoxFit.fill, isBackdrop: true),
                    )
                  : Scrollbar(
                      child: SingleChildScrollView(
                        primary: true,
                        child: Container(
                          alignment: .topCenter,
                          child: ItemDetailOverview(item: item, isSliver: false, centered: true),
                        ),
                      ),
                    ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 1,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                      child: ItemImagesButtonView(id: item.id, type: item.type, title: item.title ?? '', compact: true),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                      child: Center(
                        child: Text(
                          'Trailers',
                          style: context.theme.textTheme.titleMedium!.copyWith(
                            color: context.theme.textTheme.titleMedium!.color!.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

class ItemDetailPortraitAppbarContentSimple extends ConsumerWidget {
  const ItemDetailPortraitAppbarContentSimple({super.key, required this.item});

  final BaseSearchResult item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(fetchDetailsProvider(item.id, item.type.type));

    return Stack(
      fit: StackFit.expand,
      children: [
        IgnorePointer(
          ignoring: true,
          child: ContentImageWidget(item.posterImage, fit: BoxFit.cover, isBackdrop: item.backDropImage != null),
        ),
        IgnorePointer(
          ignoring: true,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  context.theme.colorScheme.surface.withOpacity(0.2),
                  context.theme.colorScheme.surface.withOpacity(0.2),
                  context.theme.colorScheme.surface.withOpacity(0.8),
                  context.theme.scaffoldBackgroundColor,
                ],
              ),
              border: Border.symmetric(vertical: BorderSide(color: context.theme.scaffoldBackgroundColor)),
            ),
          ),
        ),
        if (!model.isLoading)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ItemDetailMainContent(isSliver: false, showActions: false, showOverview: false, item: item),
          ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(height: 1, color: context.theme.colorScheme.onSurface.withOpacity(0.2)),
        ),
      ],
    );
  }
}

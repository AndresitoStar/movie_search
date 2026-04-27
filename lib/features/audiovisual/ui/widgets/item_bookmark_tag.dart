import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/domain/search_result.dart';

class ItemBookmarkTag extends ConsumerWidget {
  final BaseSearchResult item;

  const ItemBookmarkTag({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isLiked = model.listFavouriteId.contains(item.id);

    return Align(
      alignment: Alignment.bottomRight,
      child: /*false
          ? Builder(
              builder: (context) {
                final type = model.findTypeGivenId(item.id);
                if (type == null) {
                  return Container();
                }
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  color: context.theme.colorScheme.tertiary,
                  child: Text(
                    type,
                    style: context.theme.textTheme.bodyMedium!.copyWith(color: context.theme.colorScheme.onTertiary),
                  ),
                );
              },
            )
          : */
          Container(),
    );
  }
}

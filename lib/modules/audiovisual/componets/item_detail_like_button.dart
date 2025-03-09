import 'package:flutter/material.dart';
import 'package:movie_search/modules/account/viewModel/account_viewmodel.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/favourite/viewmodel/favourite_viewmodel.dart';
import 'package:movie_search/modules/favourite/views/bookmark_type_dialog.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/extensions.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class ItemLikeButton extends ViewModelWidget<FavouritesViewModel> {
  final double iconSize;
  final bool showDisabled;
  final BaseSearchResult item;

  ItemLikeButton({
    this.iconSize = 32,
    this.showDisabled = true,
    required this.item,
  });

  @override
  Widget build(BuildContext context, FavouritesViewModel model) {
    return Builder(
      builder: (ctx) {
        final isLiked = model.listFavouriteId.contains(item.id);
        return model.busy(item.id)
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(height: iconSize, width: iconSize, child: CircularProgressIndicator(strokeWidth: 1)),
              )
            : model.anyObjectsBusy
                ? Container()
                : Consumer<AccountViewModel>(
                    builder: (context, accountViewModel, child) {
                      if (!isLiked && !this.showDisabled) {
                        return Container();
                      }
                      return IconButton(
                        icon: Icon(isLiked ? MyIcons.favourite_on : MyIcons.favourite_off),
                        iconSize: this.iconSize,
                        padding: EdgeInsets.zero,
                        color: /*snapshot.data!.contains(id) ? Colors.red : */
                            Theme.of(context).colorScheme.onSurface,
                        onPressed: () async {
                          if (accountViewModel.userUuid == null) {
                            await context.showLoginModalBottomSheet();
                          }
                          if (accountViewModel.userUuid != null) {
                            final type =
                                isLiked ? model.findTypeGivenId(item.id) : await SelectBookmarkTypeDialog.show(context);
                            if (type != null) {
                              await model.toggleFavourite(
                                isLiked: isLiked,
                                data: item,
                                type: type,
                                userUuid: accountViewModel.userUuid!,
                                onError: (e) => context.showError(error: e.toString()),
                              );
                            }
                          }
                        },
                      );
                    },
                  );
      },
    );
  }
}

class ItemBookmarkTag extends ViewModelWidget<FavouritesViewModel> {
  final BaseSearchResult item;

  ItemBookmarkTag({required this.item});

  @override
  Widget build(BuildContext context, FavouritesViewModel model) {
    final isLiked = model.listFavouriteId.contains(item.id);

    return Align(
      alignment: Alignment.bottomRight,
      child: isLiked
          ? Builder(builder: (context) {
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
            })
          : Container(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_search/modules/account/viewModel/account_viewmodel.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/favourite/viewmodel/favourite_viewmodel.dart';
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
                            Theme.of(context).colorScheme.onBackground,
                        onPressed: () async {
                          if (accountViewModel.userUuid == null) {
                            await context.showLoginDialog();
                            Navigator.of(context).pop();
                          }
                          if (accountViewModel.userUuid != null) {
                            await model.toggleFavourite(
                              isLiked: isLiked,
                              data: item,
                              type: item.type.type, // TODO Cambiar, aki viene en que lista se quiere guardar
                              userUuid: accountViewModel.userUuid!,
                              onError: (e) => context.showError(error: e.toString()),
                            );
                          }
                        },
                      );
                    },
                  );
      },
    );
  }
}

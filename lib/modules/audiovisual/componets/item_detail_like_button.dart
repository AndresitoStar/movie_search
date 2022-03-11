import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_like_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class ItemLikeButton extends StatelessWidget {
  final double iconSize;
  final num id;
  final TMDB_API_TYPE type;
  final bool showDisabled;

  ItemLikeButton({this.iconSize = 32, this.showDisabled = true, required this.id, required this.type});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemLikeButtonViewModel>.reactive(
      viewModelBuilder: () => ItemLikeButtonViewModel(context.read(), type),
      disposeViewModel: true,
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) => !model.initialised || model.isBusy
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(height: iconSize, width: iconSize, child: CircularProgressIndicator(strokeWidth: 1)),
            )
          : model.hasError
              ? Icon(Icons.broken_image)
              : StreamBuilder<List<num?>>(
                  stream: model.stream,
                  initialData: [],
                  builder: (context, snapshot) {
                    if (!snapshot.data!.contains(id) && !this.showDisabled) {
                      return Container();
                    }
                    return IconButton(
                      icon: Icon(snapshot.data!.contains(id) ? MyIcons.favourite_on : MyIcons.favourite_off),
                      iconSize: this.iconSize,
                      padding: EdgeInsets.zero,
                      color: snapshot.data!.contains(id) ? Colors.red : Theme.of(context).colorScheme.onBackground,
                      onPressed: () {
                        return _onLikeButtonTap(context, model, snapshot.data!.contains(id));
                      },
                    );
                  }),
    );
  }

  _onLikeButtonTap(BuildContext context, ItemLikeButtonViewModel model, bool isLiked) async {
    await model.toggleFavourite(id, isLiked);
    context.scaffoldMessenger.hideCurrentSnackBar();
    context.scaffoldMessenger.showSnackBar(SnackBar(
      duration: Duration(seconds: 1),
      content: Text(isLiked ? 'Eliminado de Mis Favoritos' : 'Agregado a Mis Favoritos'),
    ));
  }
}

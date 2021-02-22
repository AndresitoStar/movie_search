import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/service/service.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_like_viewmodel.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class ItemLikeButton extends StatelessWidget {
  final double iconSize;
  final String id;
  final String type;

  ItemLikeButton({this.iconSize = 32, @required this.id, @required this.type});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemLikeButtonViewModel>.reactive(
      viewModelBuilder: () => ItemLikeButtonViewModel(
          context.read(), AudiovisualService.getInstance(), type),
      disposeViewModel: true,
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) => !model.initialised || model.isBusy
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: iconSize,
                  width: iconSize,
                  child: CircularProgressIndicator(strokeWidth: 1)),
            )
          : StreamBuilder<List<String>>(
              stream: model.stream,
              initialData: [],
              builder: (context, snapshot) {
                return IconButton(
                  icon: Icon(
                    snapshot.data.contains(id)
                        ? MyIcons.favourite_on
                        : MyIcons.favourite_off,
                  ),
                  iconSize: this.iconSize,
                  color: snapshot.data.contains(id) ? Colors.red : Colors.grey,
                  onPressed: () {
                    return _onLikeButtonTap(
                        context, model, snapshot.data.contains(id));
                  },
                );
              }),
    );
  }

  _onLikeButtonTap(
      BuildContext context, ItemLikeButtonViewModel model, bool isLiked) async {
    final ScaffoldState scaffoldState =
        context.findRootAncestorStateOfType<ScaffoldState>();
    await model.toggleFavourite(id);
    if (scaffoldState != null) {
      scaffoldState.showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text(isLiked
            ? 'Eliminado de Mis Favoritos'
            : 'Agregado a Mis Favoritos'),
      ));
    }
  }
}

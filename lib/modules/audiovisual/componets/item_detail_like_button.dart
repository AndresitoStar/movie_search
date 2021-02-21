import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:stacked/stacked.dart';

class ItemDetailLikeButton extends ViewModelWidget<ItemDetailViewModel> {
  @override
  Widget build(BuildContext context, ItemDetailViewModel<ModelBase> model) {
    return IconButton(
      icon: Icon(
        model.isFavourite ? MyIcons.favourite_on : MyIcons.favourite_off,
      ),
      iconSize: 32,
      color: model.isFavourite ? Colors.red : Colors.grey,
      onPressed: () {
        return _onLikeButtonTap(context, model, model.isFavourite);
      },
    );
  }

  Future<bool> _onLikeButtonTap(
      BuildContext context, ItemDetailViewModel model, bool isLiked) {
    final ScaffoldState scaffoldState =
        context.findRootAncestorStateOfType<ScaffoldState>();
    if (scaffoldState != null) {
      scaffoldState.showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text(isLiked
            ? 'Eliminado de Mis Favoritos'
            : 'Agregado a Mis Favoritos'),
      ));
    }
    return model.toggleFavourite();
  }
}

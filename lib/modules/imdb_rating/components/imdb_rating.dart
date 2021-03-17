import 'package:flutter/material.dart';
import 'package:movie_search/modules/imdb_rating/viewmodel/imdb_viewmodel.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:stacked/stacked.dart';

class ImbdbRatingView extends StatelessWidget {
  final String imdbId;
  final int tmdbId;
  final String type;

  ImbdbRatingView(this.tmdbId, this.type, {this.imdbId});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ImdbRatingViewModel>.reactive(
      viewModelBuilder: () =>
          ImdbRatingViewModel(this.tmdbId, this.type, imdbId: this.imdbId),
      staticChild: Icon(MyIcons.imdb, color: Colors.orange, size: 30),
      builder: (context, model, child) => Row(
        children: [
          child,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: model.initialised || model.isBusy
                ? CircularProgressIndicator(strokeWidth: 1)
                : Text('${model.data?.toStringAsFixed(1) ?? '-'}',
                    style: Theme.of(context).textTheme.headline6),
          ),
        ],
      ),
    );
  }
}

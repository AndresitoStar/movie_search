import 'package:flutter/material.dart';
import 'package:movie_search/modules/imdb_rating/viewmodel/imdb_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

class ImbdbRatingView extends StatelessWidget {
  final String? imdbId;
  final num tmdbId;
  final String type;

  ImbdbRatingView(this.tmdbId, this.type, {Key? key, required this.imdbId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ImdbRatingViewModel>.reactive(
      viewModelBuilder: () =>
          ImdbRatingViewModel(this.tmdbId, this.type, imdbId: this.imdbId),
      staticChild: Image.asset('assets/images/imdb.png', height: 34),
      builder: (context, model, child) => Chip(
        backgroundColor: Colors.transparent,
        avatar: child,
        onDeleted: model.hasError
            ? () {
                model.initialise();
              }
            : null,
        deleteIcon: model.isBusy
            ? CircularProgressIndicator(strokeWidth: 1)
            : model.hasError
                ? Icon(Icons.refresh)
                : null,
        label: model.hasError || !model.initialised || model.isBusy
            ? Text('')
            : Text(
                model.data! >= 0 ? '${model.data?.toStringAsFixed(1)}' : 'N/A',
              ),
      ),
    );
  }
}

class ContentRatingView extends StatelessWidget {
  final num id;
  final TMDB_API_TYPE type;

  ContentRatingView(this.id, this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContentRatingViewModel>.reactive(
      viewModelBuilder: () => ContentRatingViewModel(this.id, this.type),
      builder: (context, model, child) => model.hasError || !model.initialised || model.data?.isEmpty == true
          ? SizedBox()
          : Chip(
              backgroundColor: Colors.transparent,
              onDeleted: model.hasError
                  ? () {
                      model.initialise();
                    }
                  : null,
              deleteIcon: model.isBusy
                  ? CircularProgressIndicator(strokeWidth: 1)
                  : model.hasError
                      ? Icon(Icons.refresh)
                      : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: context.theme.dividerColor),
              ),
              label: model.hasError || !model.initialised || model.isBusy
                  ? Text('-')
                  : Text(model.data ?? '-'),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/review_view_model.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

class ReviewPage extends StatelessWidget {
  static const String routeName = "/review";

  late BaseSearchResult param;

  @override
  Widget build(BuildContext context) {
    param = ModalRoute.of(context)!.settings.arguments as BaseSearchResult;

    return ViewModelBuilder<ReviewViewModel>.reactive(
      viewModelBuilder: () => ReviewViewModel(type: param.type.type, id: param.id),
      builder: (context, model, _) => Scaffold(
        appBar: AppBar(title: Text('Comentarios')),
        body: !model.initialised || model.isBusy
            ? Center(child: CircularProgressIndicator(strokeWidth: 1))
            : ListView.separated(
                itemCount: model.reviews.length,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                itemBuilder: (context, i) => Card(
                  child: ListTile(
                    title: Text(model.reviews[i].author ?? ''),
                    subtitle: Text(model.reviews[i].content ?? ''),
                    subtitleTextStyle: context.theme.textTheme.bodyLarge,
                  ),
                ),
                separatorBuilder: (context, index) => Container(height: 20),
              ),
      ),
    );
  }
}

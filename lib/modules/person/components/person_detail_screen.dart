import 'package:flutter/material.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/componets/item_recomendation_horizontal_list.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_recomendations_viewmodel.dart';
import 'package:movie_search/modules/person/components/person_detail_appbar.dart';
import 'package:movie_search/modules/person/components/person_detail_content.dart';
import 'package:movie_search/modules/person/viewmodel/person_detail_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class PersonDetailScreen extends StatelessWidget {
  final Person param;

  const PersonDetailScreen({Key key, @required this.param}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => PersonDetailViewModel(param, context.read()),
      builder: (context, model, _) => SafeArea(
        child: Scaffold(
          body: model.hasError
              ? Center(
                  child: Text('${model.modelError?.toString()}'),
                )
              : CustomScrollView(
                  controller: model.scrollController,
                  slivers: <Widget>[
                    PersonDetailSliverAppBar(),
                    if (model.initialised) PersonDetailContent(),
                    if (model.initialised)
                      ItemDetailRecommendationHorizontalList(
                        TMDB_API_TYPE.PERSON.type,
                        param.id,
                        ERecommendationType.Credit,
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}

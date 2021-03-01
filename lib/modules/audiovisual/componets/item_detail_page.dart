import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_content.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_secondary_content.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_recomendations_viewmodel.dart';
import 'package:movie_search/modules/person/components/person_horizontal_list.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:movie_search/providers/util.dart';
import 'item_detail_appbar.dart';
import 'item_recomendation_horizontal_list.dart';

import 'dart:math' as math;

class ItemDetailPage extends StatelessWidget {
  final BaseSearchResult item;

  const ItemDetailPage({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemDetailViewModel>.reactive(
      viewModelBuilder: () => ItemDetailViewModel(item, context.read()),
      builder: (context, model, _) => Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          top: true,
          child: Scaffold(
            body: model.hasError
                ? Center(
                    child: Text('${model.modelError?.toString()}'),
                  )
                : CustomScrollView(
                    controller: model.scrollController,
                    slivers: <Widget>[
                      ItemDetailSliverAppBar(),
                      if (model.initialised) ItemDetailMainContent(),
                      if (model.initialised)
                        CreditHorizontalList(item.type.type, item.id),
                      if (model.initialised) ItemDetailSecondaryContent(),
                      if (model.initialised)
                        ItemDetailRecommendationHorizontalList(
                          item.type.type,
                          item.id,
                          ERecommendationType.Recommendation,
                        ),
                      if (model.initialised)
                        ItemDetailRecommendationHorizontalList(
                          item.type.type,
                          item.id,
                          ERecommendationType.Similar,
                        ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_content.dart';
import 'package:provider/provider.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/service/service.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'item_detail_appbar.dart';
import 'item_detail_carousel.dart';
import 'item_recomendation_horizontal_list.dart';

class ItemDetailPage<T extends ModelBase> extends StatelessWidget {
  final ModelBase item;

  const ItemDetailPage({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemDetailViewModel>.reactive(
      viewModelBuilder: () => ItemDetailViewModel<T>(
          item, AudiovisualService.getInstance(), context.read()),
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
                      if (model.initialised) ItemDetailContent(),
                      if (model.initialised &&
                          model.data.imageList != null &&
                          model.data.imageList.isNotEmpty)
                        ItemDetailCarouselImages(imageList: model.data.imageList),
                      if (model.initialised) ItemDetailRecomendationHorizontalList(model.data.type, model.data.id),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/model/image.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_images_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/rest/resolver.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/circular_button.dart';
import 'package:stacked/stacked.dart';

import 'item_detail_main_image.dart';

class ItemImagesButtonView extends StatelessWidget {
  final BaseSearchResult param;

  const ItemImagesButtonView({Key key, this.param}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemImagesViewModel>.reactive(
      viewModelBuilder: () => ItemImagesViewModel(param.id, param.type.type),
      builder: (context, model, child) => !model.initialised || model.isBusy
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: CircularProgressIndicator(strokeWidth: 1),
            )
          : MyCircularButton(
              onPressed: model.images.isEmpty
                  ? null
                  : () => Navigator.push(
                      context, Routes.defaultRoute(null, ItemImagesPage(param: param, imagesMap: model.images))),
              icon: Icon(MyIcons.gallery)),
    );
  }
}

class ItemImagesPage extends StatelessWidget {
  final BaseSearchResult param;
  final Map<MediaImageType, List<MediaImage>> imagesMap;

  const ItemImagesPage({Key key, this.param, this.imagesMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(param.title),
        primary: true,
        titleSpacing: 0,
        elevation: 0,
        leading: IconButton(icon: Icon(MyIcons.arrow_left), onPressed: () => Navigator.of(context).pop()),
      ),
      body: Builder(builder: (context) {
        return Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (MediaImageType type in MediaImageType.values)
                  if (imagesMap[type].length > 0)
                    ExpansionTile(
                      title: Text('${type.title} (${imagesMap[type].length})'),
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          padding: const EdgeInsets.all(10.0),
                          itemCount: imagesMap[type].length,
                          itemBuilder: (ctx, i) => ContentImageWidget(imagesMap[type][i].filePath, fit: BoxFit.cover),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: getColumns(context),
                            childAspectRatio: imagesMap[type].map((e) => e.aspectRatio).reduce(max),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                        )
                      ],
                    ),
              ],
            ),
          ),
        );
      }),
    );
  }

  int getColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width ~/ 150).clamp(1, 8);
  }
}

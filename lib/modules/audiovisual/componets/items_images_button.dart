import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/model/image.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_images_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/rest/resolver.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/dialog_image.dart';
import 'package:stacked/stacked.dart';

import 'item_detail_main_image.dart';

class ItemImagesButtonView extends StatelessWidget {
  final num id;
  final TMDB_API_TYPE type;
  final String title;

  const ItemImagesButtonView({
    Key? key,
    required this.id,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ItemImagesViewModel>.reactive(
      viewModelBuilder: () => ItemImagesViewModel(id, type.type),
      builder: (context, model, child) => !model.initialised || model.isBusy
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: CircularProgressIndicator(strokeWidth: 1),
            )
          : ShowImagesButton(
              images: model.images,
              title: title,
            ),
    );
  }
}

class ShowImagesButton extends StatelessWidget {
  final String title;
  final Map<MediaImageType, List<MediaImage>> images;

  const ShowImagesButton(
      {super.key, required this.title, required this.images});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: images.isEmpty
          ? null
          : () => Navigator.push(
              context,
              Routes.defaultRoute(
                  null, ItemImagesPage(title: title, imagesMap: images))),
      icon: Icon(
        MyIcons.gallery,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

class ItemImagesPage extends StatelessWidget {
  final String title;
  final Map<MediaImageType, List<MediaImage>> imagesMap;
  final List<String> _images = [];

  ItemImagesPage({Key? key, required this.title, required this.imagesMap})
      : super(key: key) {
    for (MediaImageType type in [
      MediaImageType.POSTER,
      MediaImageType.BACKDROP,
      MediaImageType.PROFILES
    ]) {
      if (imagesMap.containsKey(type) && imagesMap[type]!.length > 0)
        _images.addAll(imagesMap[type]!.map((e) => e.filePath!).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        primary: true,
        titleSpacing: 0,
        elevation: 0,
        leading: IconButton(
            icon: Icon(MyIcons.arrow_left),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: Builder(builder: (context) {
        return Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (MediaImageType type in [
                  MediaImageType.POSTER,
                  MediaImageType.BACKDROP,
                  MediaImageType.PROFILES
                ])
                  if (imagesMap.containsKey(type) &&
                      imagesMap[type]!.length > 0)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: imagesMap[type]!.length,
                      itemBuilder: (ctx, i) {
                        return ContentImageWidget(
                          imagesMap[type]![i].filePath,
                          fit: BoxFit.cover,
                          onSelectImage: () => onSelectImage(
                              context, imagesMap[type]![i].filePath),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: getColumns(context),
                        childAspectRatio: imagesMap[type]!
                            .map((e) => e.aspectRatio!)
                            .reduce(max),
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 3,
                      ),
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
    return (width ~/ 150).clamp(1, 6);
  }

  onSelectImage(BuildContext context, String? filePath) {
    if (filePath == null) return;
    final index = _images.indexOf(filePath);
    DialogImage.showCarousel(
        context: context, images: _images, currentImage: index);
  }
}

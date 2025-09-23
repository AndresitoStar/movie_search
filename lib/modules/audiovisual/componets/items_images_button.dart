import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  const ShowImagesButton({super.key, required this.title, required this.images});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: images.isEmpty ? null : () => context.push('/images', extra: {
        'title': title,
        'imagesMap': images,
      }),
      icon: Icon(
        MyIcons.gallery,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}



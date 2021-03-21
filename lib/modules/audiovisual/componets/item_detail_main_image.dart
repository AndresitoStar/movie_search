import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/widgets/default_image.dart';
import 'package:movie_search/ui/widgets/dialog_image.dart';
import 'package:stacked/stacked.dart';

class DetailMainImage extends ViewModelWidget<ItemDetailViewModel> {
  final bool landscape;

  DetailMainImage({this.landscape = false});

  @override
  Widget build(BuildContext context, model) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: GestureDetector(
        onTap: model.withImageList || model.withImage
            ? () {
                DialogImage.show(
                    context: context,
                    imageUrl:
                        '${model.baseImageUrl}${model.images[model.currentImage]}');
              }
            : null,
        child: Stack(
          fit: StackFit.expand,
          children: [
            model.withImageList
                ? ContentImageWidget(model.images[model.currentImage])
                : model.withImage
                    ? ContentImageWidget(model.image)
                    : Card(
                        child: PlaceholderImage(height: 250),
                      ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: landscape ? Alignment.centerLeft : Alignment.topCenter,
                  end: landscape
                      ? Alignment.centerRight
                      : Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    Theme.of(context).scaffoldBackgroundColor
                  ],
                ),
                border: Border.all(color: Theme.of(context).scaffoldBackgroundColor),
              ),
            ),
            if (!model.initialised)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: LinearProgressIndicator(),
              )
          ],
        ),
      ),
    );
  }
}

class ContentImageWidget extends ViewModelWidget<ItemDetailViewModel> {
  final String imagePath;

  ContentImageWidget(this.imagePath, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onTap: () => DialogImage.show(
          context: context, imageUrl: '${model.baseImageUrl}$imagePath'),
      child: Container(
        child: CachedNetworkImage(
          imageUrl: '${model.baseImageUrl}$imagePath',
          placeholder: (_, __) => CachedNetworkImage(
            width: double.infinity,
            fit: BoxFit.cover,
            imageUrl: '$URL_IMAGE_SMALL$imagePath',
          ),
          errorWidget: (ctx, _, __) =>
              PlaceholderImage(height: MediaQuery.of(ctx).size.height * 0.6),
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}

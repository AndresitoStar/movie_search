import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/widgets/default_image.dart';
import 'package:movie_search/ui/widgets/dialog_image.dart';
import 'package:stacked/stacked.dart';

class DetailMainImage extends ViewModelWidget<ItemDetailViewModel> {
  @override
  Widget build(BuildContext context, model) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Material(
        child: Stack(
          fit: StackFit.expand,
          children: [
            model.withImageList
                ? CarouselSlider(
                    items: model.images
                        .map((e) => ContentImageWidget(e.filePath))
                        .toList(),
                    options: CarouselOptions(
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      disableCenter: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 100),
                      autoPlayCurve: Curves.bounceIn,
                      enlargeCenterPage: false,
                      scrollDirection: Axis.horizontal,
                    ))
                : model.withImage
                    ? ContentImageWidget(model.image)
                    : Card(
                        child: PlaceholderImage(height: 250),
                      ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    Theme.of(context).scaffoldBackgroundColor
                  ],
                ),
                border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
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
  const ContentImageWidget(
    this.imagePath, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onTap: () => DialogImage.show(
          context: context, imageUrl: '${model.baseImageUrl}$imagePath'),
      child: CachedNetworkImage(
        imageUrl: '${model.baseImageUrl}$imagePath',
        placeholder: (_, __) => CachedNetworkImage(
            fit: BoxFit.cover, imageUrl: '$URL_IMAGE_SMALL$imagePath'),
        errorWidget: (ctx, _, __) =>
            PlaceholderImage(height: MediaQuery.of(ctx).size.height * 0.6),
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }
}

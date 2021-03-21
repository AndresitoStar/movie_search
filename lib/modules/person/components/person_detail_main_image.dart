import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/person/viewmodel/person_detail_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/widgets/default_image.dart';
import 'package:movie_search/ui/widgets/dialog_image.dart';
import 'package:stacked/stacked.dart';

class PersonDetailMainImage extends ViewModelWidget<PersonDetailViewModel> {
  final bool landscape;

  PersonDetailMainImage({this.landscape = false});

  @override
  Widget build(BuildContext context, PersonDetailViewModel model) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Material(
        child: Stack(
          fit: StackFit.expand,
          children: [
            model.withImageList
                ? CarouselSlider(
                    items: model.images
                        .map((e) => PersonImageWidget(e.filePath))
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
                    ),
                  )
                : model.withImage
                    ? PersonImageWidget(model.image)
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
                border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor),
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

class PersonImageWidget extends ViewModelWidget<PersonDetailViewModel> {
  final String imagePath;
  const PersonImageWidget(
    this.imagePath, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onLongPress: () => model.toggleHighQualityImage(),
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

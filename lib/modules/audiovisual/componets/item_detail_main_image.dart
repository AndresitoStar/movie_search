import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/modules/dialog_image/download_image_button.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/circular_button.dart';
import 'package:movie_search/ui/widgets/default_image.dart';
import 'package:movie_search/ui/widgets/dialog_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stacked/stacked.dart';

class DetailMainImage extends ViewModelWidget<ItemDetailViewModel> {
  final bool landscape;

  DetailMainImage({this.landscape = false});

  @override
  Widget build(BuildContext context, model) {
    final theme = Theme.of(context);
    return Container(
      color: Theme
          .of(context)
          .scaffoldBackgroundColor,
      child: Stack(
        fit: StackFit.expand,
        children: [
          model.withImageList
              ? ContentImageCarousel()
              : model.withImage
              ? ContentImageWidget(model.posterImageUrl)
              : Card(child: PlaceholderImage(height: 250)),
          if (!landscape)
            IgnorePointer(
              ignoring: true,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: landscape ? Alignment.centerLeft : Alignment.topCenter,
                    end: landscape ? Alignment.centerRight : Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Theme
                          .of(context)
                          .scaffoldBackgroundColor
                    ],
                  ),
                  border: Border.all(color: Theme
                      .of(context)
                      .scaffoldBackgroundColor),
                ),
              ),
            ),
          if (!model.isHighQualityImage)
            Positioned(
              top: 5,
              right: 5,
              child: MyCircularButton(
                icon: Icon(MyIcons.quality),
                onPressed: model.isHighQualityImage ? null : () => model.toggleHighQualityImage(),
              ),
            ),
          if (model.withImageList)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                  gradient: RadialGradient(
                    radius: 3,
                    focalRadius: 5,
                    colors: [
                      Colors.black26,
                      Colors.black26,
                      Colors.transparent,
                    ],
                  ),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: AnimatedSmoothIndicator(
                  activeIndex: model.currentImage,
                  count: model.images.length,
                  effect: ScrollingDotsEffect(
                    activeDotColor: theme.accentColor,
                    dotColor: Colors.white30,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

class ContentImageWidget extends StatelessWidget {
  final String imagePath;
  final BoxFit fit;
  final String baseUrl;

  ContentImageWidget(this.imagePath, {
    Key key,
    this.fit = BoxFit.fitWidth,
    this.baseUrl = URL_IMAGE_MEDIUM,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => DialogImage.show(context: context, imageUrl: '$baseUrl$imagePath'),
      child: Container(
        color: Theme
            .of(context)
            .scaffoldBackgroundColor,
        child: CachedNetworkImage(
          imageUrl: '$baseUrl$imagePath',
          placeholder: (_, __) =>
              CachedNetworkImage(
                // width: double.infinity,
                fit: fit,
                imageUrl: '$URL_IMAGE_SMALL$imagePath',
              ),
          errorWidget: (ctx, _, __) =>
              PlaceholderImage(height: MediaQuery
                  .of(ctx)
                  .size
                  .height * 0.6),
          fit: fit,
          // width: double.infinity,
        ),
      ),
    );
  }
}

class ContentImageCarousel extends ViewModelWidget<ItemDetailViewModel> {
  @override
  Widget build(BuildContext context, ItemDetailViewModel model) {
    return CarouselSlider(
      items: model.images.map((i) => ContentImageWidget(i)).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        initialPage: 0,
        // height: MediaQuery.of(context).size.height * 2 / 3,
        enableInfiniteScroll: false,
        disableCenter: true,
        reverse: false,
        autoPlay: false,
        onPageChanged: (index, reason) => model.changeCurrentImage(index),
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

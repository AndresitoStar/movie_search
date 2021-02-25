import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/widgets/default_image.dart';
import 'package:movie_search/ui/widgets/dialog_image.dart';

class ItemDetailCarouselImages extends StatelessWidget {
  final List<String> imageList;

  const ItemDetailCarouselImages({Key key, @required this.imageList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = imageList
        .toSet()
        .map(
          (imageUrl) => GestureDetector(
            onTap: () => DialogImage.show(context: context, imageUrl: '$URL_IMAGE_MEDIUM$imageUrl'),
            child: Card(
              clipBehavior: Clip.hardEdge,
              color: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              child: CachedNetworkImage(
                imageUrl: '$URL_IMAGE_MEDIUM$imageUrl',
                placeholder: (_, __) => CachedNetworkImage(
                    fit: BoxFit.cover, imageUrl: '$URL_IMAGE_SMALL$imageUrl'),
                errorWidget: (ctx, _, __) => PlaceholderImage(height: 400),
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
            ),
          ),
        )
        .toList();
    return SliverToBoxAdapter(
      child: Container(
        height: 400,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: CarouselSlider(
            items: items,
            options: CarouselOptions(
              height: 400,
              aspectRatio: 16 / 9,
              viewportFraction: 0.7,
              initialPage: 0,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            )),
      ),
    );
  }
}

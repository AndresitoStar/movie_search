import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movie_search/modules/dialog_image/dialog_image_viewmodel.dart';
import 'package:movie_search/modules/dialog_image/download_image_button.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stacked/stacked.dart';

import 'circular_button.dart';

class DialogImage extends StatefulWidget {
  final String? imageUrl;
  final List<String>? images;
  final int? currentImage;
  final String? baseUrl;

  const DialogImage({
    Key? key,
    this.images,
    this.currentImage,
    this.baseUrl,
    this.imageUrl,
  })  : assert(imageUrl != null || (images != null && currentImage != null)),
        super(key: key);

  static Future show(
      {required BuildContext context,
      required String imageUrl,
      String baseUrl = URL_IMAGE_MEDIUM}) {
    return showDialog(
      context: context,
      builder: (context) => DialogImage(imageUrl: imageUrl, baseUrl: baseUrl),
    );
  }

  static Future showCarousel({
    required BuildContext context,
    required List<String> images,
    required int currentImage,
  }) {
    return showDialog(
      context: context,
      builder: (context) =>
          DialogImage(currentImage: currentImage, images: images),
    );
  }

  @override
  _DialogImageState createState() => _DialogImageState();
}

class _DialogImageState extends State<DialogImage> {
  late String baseUrl;

  @override
  void initState() {
    baseUrl = widget.baseUrl ?? URL_IMAGE_MEDIUM;
    if (widget.imageUrl != null) _checkImageCachedExist();
    super.initState();
  }

  Future _checkImageCachedExist() async {
    bool exist = false;
    try {
      var file = await DefaultCacheManager()
          .getFileFromCache(URL_IMAGE_BIG + widget.imageUrl!);
      exist = await file?.file.exists() ?? false;
    } catch (e) {
      print(e);
    }
    if (exist) {
      setState(() {
        baseUrl = URL_IMAGE_BIG;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CarouselController _carouselController = CarouselController();
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: ViewModelBuilder<DialogImageViewModel>.reactive(
        viewModelBuilder: () => DialogImageViewModel(
            index: widget.currentImage ?? 0,
            length: widget.images?.length ?? 1),
        builder: (context, model, _) => Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 6.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.transparent),
                width: MediaQuery.of(context).size.width,
              ),
            ),
            if (widget.imageUrl != null) _getImage(widget.imageUrl!),
            if (widget.images != null && widget.currentImage != null)
              CarouselSlider(
                carouselController: _carouselController,
                items: widget.images!.map<Widget>((e) => _getImage(e)).toList(),
                options: CarouselOptions(
                  viewportFraction: 0.95,
                  initialPage: widget.currentImage!,
                  enableInfiniteScroll: false,
                  disableCenter: true,
                  reverse: false,
                  onPageChanged: (index, reason) => model.updateIndex(index),
                  autoPlay: false,
                  enlargeCenterPage: false,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            if (widget.images != null &&
                widget.currentImage != null &&
                model.canGoBack)
              Positioned(
                // bottom: 50,
                left: 0,
                child: MyCircularButton(
                  icon: Icon(MyIcons.arrow_left),
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  onPressed: () => _carouselController.previousPage(),
                ),
              ),
            if (widget.images != null &&
                widget.currentImage != null &&
                model.canGoForward)
              Positioned(
                // bottom: 50,
                right: 5,
                child: MyCircularButton(
                  icon: Icon(MyIcons.arrow_right),
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  onPressed: () => _carouselController.nextPage(),
                ),
              ),
            if (widget.images != null && widget.currentImage != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  color: Colors.black26,
                  child: AnimatedSmoothIndicator(
                    activeIndex: model.index,
                    count: widget.images!.length,
                    effect: ScrollingDotsEffect(
                      activeDotColor: Theme.of(context).colorScheme.secondary,
                      dotColor: Colors.white30,
                    ),
                  ),
                ),
              ),
            Positioned(
              right: 50,
              top: 0,
              child: ImageDownloadButton(
                widget.imageUrl ?? widget.images![widget.currentImage!],
                DateTime.now().toString(),
              ),
            ),
            Positioned(
              right: 10,
              top: 0,
              child: MyCircularButton(
                icon: Icon(MyIcons.clear),
                color: Colors.red,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            if (baseUrl != URL_IMAGE_BIG)
              Positioned(
                right: 72,
                top: 0,
                child: MyCircularButton(
                  icon: Icon(MyIcons.quality,
                      color: Theme.of(context).colorScheme.onPrimary),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    setState(() {
                      baseUrl = URL_IMAGE_BIG;
                    });
                  },
                ),
              )
          ],
        ),
      ),
    );
  }

  _cacheImage(String url) async {
    try {
      Uint8List bytes = (await NetworkAssetBundle(Uri.parse(url)).load(url))
          .buffer
          .asUint8List();
      DefaultCacheManager().putFile(url, Uint8List.fromList(bytes), eTag: url);
    } catch (e) {
      print('>>> $e');
    }
  }

  _getImage(String image) {
    _cacheImage(baseUrl + image);
    return ExtendedImage.network(
      baseUrl + image,
      fit: BoxFit.contain,
      mode: ExtendedImageMode.gesture,
      initGestureConfigHandler: (state) => GestureConfig(
        minScale: 0.9,
        animationMinScale: 0.7,
        maxScale: 3.0,
        animationMaxScale: 3.5,
        speed: 1.0,
        inertialSpeed: 100.0,
        initialScale: 0.9,
        inPageView: true,
        initialAlignment: InitialAlignment.center,
      ),
    );
  }
}

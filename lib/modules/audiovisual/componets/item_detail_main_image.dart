import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/widgets/default_image.dart';
import 'package:stacked/stacked.dart';

class ItemDetailMainImage extends ViewModelWidget<ItemDetailViewModel> {
  @override
  Widget build(BuildContext context, model) {
    final mq = MediaQuery.of(context);
    return Container(
      height: mq.size.height / mq.devicePixelRatio * 2,
      color: Theme.of(context).primaryColor,
      child: Material(
        child: GestureDetector(
          onTap: model.withImage
              ? () => _previewImageDialog(
                  context, '${model.baseImageUrl}${model.image}')
              : null,
          child: model.withImage
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: '${model.baseImageUrl}${model.image}',
                      color: Colors.black12,
                      colorBlendMode: BlendMode.darken,
                      placeholder: (_, __) => CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: '$URL_IMAGE_SMALL${model.data?.image}'),
                      errorWidget: (ctx, _, __) => PlaceholderImage(
                          height: MediaQuery.of(ctx).size.height * 0.6),
                      fit: BoxFit.cover,
                      width: double.infinity,
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
                  ],
                )
              : PlaceholderImage(height: mq.size.height * 0.6),
        ),
      ),
    );
  }

  _previewImageDialog(BuildContext context, String imageUrl) {
    showDialog(
        context: context,
        builder: (context) => MediaQuery.removeViewInsets(
              removeLeft: true,
              removeTop: true,
              removeRight: true,
              removeBottom: true,
              context: context,
              child: AlertDialog(
                title: ListTile(
                  contentPadding: EdgeInsets.zero,
                  trailing: CircleAvatar(
                    backgroundColor: Colors.white30,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      iconSize: 24,
                      color: Colors.black87,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                insetPadding: EdgeInsets.zero,
                elevation: 0,
                backgroundColor: Colors.black54,
                content: Builder(builder: (context) {
                  var height = MediaQuery.of(context).size.height;
                  return Container(
                    height: height - 20,
                    width: double.infinity,
                    child: ExtendedImage.network(
                      imageUrl,
                      fit: BoxFit.fitWidth,
                      //enableLoadState: false,
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
                    ),
                  );
                }),
              ),
            ));
  }
}

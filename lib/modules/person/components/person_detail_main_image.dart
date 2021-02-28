import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/person/viewmodel/person_detail_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/default_image.dart';
import 'package:movie_search/ui/widgets/dialog_image.dart';
import 'package:stacked/stacked.dart';

class PersonDetailMainImage extends ViewModelWidget<PersonDetailViewModel> {
  @override
  Widget build(BuildContext context, PersonDetailViewModel model) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Material(
        child: GestureDetector(
          onTap: model.withImage
              ? () => DialogImage.show(
                  context: context,
                  imageUrl: '${model.baseImageUrl}${model.image}')
              : null,
          child: Stack(
            fit: StackFit.expand,
            children: [
              model.withImage
                  ? CachedNetworkImage(
                      imageUrl: '${model.baseImageUrl}${model.image}',
                      placeholder: (_, __) => CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: '$URL_IMAGE_SMALL${model.image}'),
                      errorWidget: (ctx, _, __) => PlaceholderImage(
                          height: MediaQuery.of(ctx).size.height * 0.6),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : Card(
                      child: LayoutBuilder(
                          builder: (context, constraint) => Icon(
                              model.param.gender == 1
                                  ? MyIcons.castMale
                                  : MyIcons.castFemale,
                              size: constraint.biggest.width)),
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
      ),
    );
  }
}
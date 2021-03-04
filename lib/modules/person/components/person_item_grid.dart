import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_like_button.dart';
import 'package:movie_search/modules/person/components/person_detail_screen.dart';
import 'package:movie_search/modules/person/service/service.dart';
import 'package:movie_search/modules/person/viewmodel/person_item_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:stacked/stacked.dart';

import 'package:provider/provider.dart';

class PersonItemGridView extends StatelessWidget {
  final Person person;

  const PersonItemGridView({Key key, this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PersonItemViewModel>.reactive(
      viewModelBuilder: () => PersonItemViewModel(
          PersonService.getInstance(), this.person, context.read()),
      disposeViewModel: true,
      builder: (context, model, child) {
        if (!model.initialised) return GridItemPlaceholder();
        return OpenContainer(
          closedColor: Colors.transparent,
          openColor: Colors.transparent,
          transitionDuration: Duration(milliseconds: 400),
          closedElevation: 0.0,
          openElevation: 0.0,
          closedBuilder: (context, open) => Card(
            margin: const EdgeInsets.all(10),
            elevation: 5,
            clipBehavior: Clip.hardEdge,
            color: Theme.of(context).cardTheme.color,
            child: GestureDetector(
              onTap: open,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 5,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            clipBehavior: Clip.hardEdge,
                            child: person.profilePath != null
                                ? CachedNetworkImage(
                                    imageUrl:
                                        '${model.baseImageUrl}${person.profilePath}',
                                    placeholder: (_, __) => Container(
                                        color: Colors.transparent,
                                        child: Center(
                                            child:
                                                CircularProgressIndicator())),
                                    errorWidget: (ctx, _, __) => Container(
                                        color: Colors.transparent,
                                        child: Center(
                                            child:
                                                Icon(MyIcons.default_image))),
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    child: LayoutBuilder(
                                        builder: (context, constraint) => Icon(
                                            person.gender == 1
                                                ? MyIcons.castMale
                                                : MyIcons.castFemale,
                                            size: constraint.biggest.width)),
                                  ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: CircleAvatar(
                              radius: 21,
                              backgroundColor: Colors.black,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: ItemLikeButton(
                                  id: person.id,
                                  type: TMDB_API_TYPE.PERSON,
                                  iconSize: 24,
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                  ListTile(
                    title: Text(
                      person.name ?? '' + '\n',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 16, color: Theme.of(context).accentColor),
                    ),
                    subtitle: Text(
                      '${person?.character ?? ''}' ?? '',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          .copyWith(fontSize: 14, fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              ),
            ),
          ),
          onClosed: (data) => model.initialise(),
          openBuilder: (context, close) => PersonDetailScreen(param: person),
        );
      },
    );
  }
}

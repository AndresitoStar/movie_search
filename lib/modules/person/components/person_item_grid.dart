import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_like_button.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_main_image.dart';
import 'package:movie_search/modules/person/components/person_detail_screen.dart';
import 'package:movie_search/modules/person/viewmodel/person_item_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:stacked/stacked.dart';

class PersonItemGridView extends StatelessWidget {
  final Person person;

  const PersonItemGridView({Key key, this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PersonItemViewModel>.reactive(
      viewModelBuilder: () => PersonItemViewModel(this.person),
      disposeViewModel: true,
      builder: (context, model, child) {
        if (!model.initialised) return GridItemPlaceholder();
        return Stack(
          children: [
            Card(
              margin: const EdgeInsets.all(10),
              elevation: 5,
              clipBehavior: Clip.hardEdge,
              color: Theme.of(context).cardTheme.color,
              child: GestureDetector(
                onTap: () => _onPressed(context),
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
                                  ? ContentImageWidget(person.profilePath, fit: BoxFit.cover, ignorePointer: true)
                                  : Container(
                                      child: LayoutBuilder(
                                          builder: (context, constraint) => Icon(
                                              person.gender == 1 ? MyIcons.castMale : MyIcons.castFemale,
                                              size: constraint.biggest.width)),
                                    ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: ClipRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 14.0, sigmaY: 14.0),
                                  child: Container(
                                    color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
                                    child: ListTile(
                                      title: Text(person.name ?? '' + '\n',
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                                fontSize: 18,
                                              )),
                                      subtitle: person?.character == null
                                          ? null
                                          : Text(
                                              '${person?.character ?? ''}' ?? '',
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  .copyWith(fontSize: 13, fontStyle: FontStyle.italic),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 60,
              right: 0,
              child: Container(
                child: ItemLikeButton(
                  id: person.id,
                  type: TMDB_API_TYPE.PERSON,
                  iconSize: 28,
                  showDisabled: false,
                ),
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  _onPressed(BuildContext context) =>
      Navigator.of(context).push(Routes.defaultRoute(null, PersonDetailScreen(param: person)));
}

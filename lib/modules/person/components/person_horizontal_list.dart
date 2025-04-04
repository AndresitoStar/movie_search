import 'package:flutter/material.dart';
import 'package:movie_search/model/api/models/person.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/audiovisual/componets/item_list_page.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/person/viewmodel/cast_list_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:stacked/stacked.dart';

class CreditHorizontalList extends StatelessWidget {
  final String type;
  final num typeId;
  final bool isSliver;

  const CreditHorizontalList(this.type, this.typeId, {Key? key, this.isSliver = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CastListViewModel>.reactive(
      viewModelBuilder: () => CastListViewModel(this.type, this.typeId),
      builder: (context, model, _) {
        final height = 300.0;
        final child = !model.initialised || model.isBusy
            ? Container(child: LinearProgressIndicator())
            : model.items.length == 0
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        title: Text(
                          'Reparto',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: context.theme.colorScheme.secondary),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.grid_view_rounded),
                          onPressed: () => Navigator.of(context).push(
                            Routes.defaultRoute(
                              null,
                              ItemListPage(
                                items: model.items.map((e) => BaseSearchResult.fromPerson(e)).toList(),
                                title: 'Reparto',
                                heroTagPrefix: 'person-$typeId',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(minHeight: height, maxHeight: height + 50),
                        child: model.isBusy
                            ? ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: (ctx, i) => AspectRatio(
                                  child: GridItemPlaceholder(),
                                  aspectRatio: 8 / 16,
                                ),
                              )
                            : PersonHorizontalList(items: model.items, tag: '$typeId'),
                      ),
                    ],
                  );
        return isSliver
            ? SliverToBoxAdapter(
                child: child,
              )
            : Container(child: child);
      },
    );
  }
}

class PersonHorizontalList extends StatelessWidget {
  const PersonHorizontalList({Key? key, required this.items, required this.tag}) : super(key: key);

  final List<Person> items;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (ctx, i) => AspectRatio(
        child: ItemGridView(
          item: BaseSearchResult.fromPerson(items[i]),
          heroTagPrefix: '$i-person-$tag-',
          showType: false,
          showTitles: true,
        ),
        aspectRatio: 0.669,
      ),
    );
  }
}

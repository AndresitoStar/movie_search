import 'package:flutter/material.dart';
import 'package:movie_search/modules/person/components/person_item_grid.dart';
import 'package:movie_search/modules/person/viewmodel/cast_list_viewmodel.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:stacked/stacked.dart';

class CreditHorizontalList extends StatelessWidget {
  final String type;
  final int typeId;
  final bool isSliver;

  const CreditHorizontalList(this.type, this.typeId,
      {Key key, this.isSliver = true})
      : super(key: key);

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
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                      ),
                      Container(
                        constraints: BoxConstraints(
                            minHeight: height, maxHeight: height + 50),
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
                            : ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: model.items.length,
                                itemBuilder: (ctx, i) => AspectRatio(
                                  child: PersonItemGridView(
                                      person: model.items[i]),
                                  aspectRatio: 8 / 16,
                                ),
                              ),
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

import 'package:flutter/material.dart';
import 'package:movie_search/modules/person/components/person_item_grid.dart';
import 'package:movie_search/modules/person/viewmodel/cast_list_viewmodel.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:stacked/stacked.dart';

class CreditHorizontalList extends StatelessWidget {
  final String type;
  final int typeId;

  const CreditHorizontalList(this.type, this.typeId, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CastListViewModel>.reactive(
      viewModelBuilder: () => CastListViewModel(this.type, this.typeId),
      builder: (context, model, _) {
        final height = MediaQuery.of(context).size.width * 0.75;
        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                  title: Text('Reparto',
                      style: Theme.of(context).textTheme.headline5)),
              Container(
                constraints: BoxConstraints(
                    minHeight: height - 100, maxHeight: height + 50),
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
                          child: PersonItemGridView(person: model.items[i]),
                          aspectRatio: 8 / 16,
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

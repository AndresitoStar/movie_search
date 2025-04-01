import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/ui/icons.dart';

import '../../../core/content_preview.dart';

class ItemListPage extends StatelessWidget {
  final List<BaseSearchResult> items;
  final String title;
  final String? heroTagPrefix;

  const ItemListPage(
      {Key? key, required this.items, required this.title, this.heroTagPrefix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        forceMaterialTransparency: true,
        titleSpacing: 0,
        elevation: 0,
        leading: IconButton(
            icon: Icon(MyIcons.arrow_left),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: items.length,
        itemBuilder: (ctx, i) => ItemGridView(
          item: items[i],
          showType: false,
          showTitles: true,
          heroTagPrefix: '$i-${this.heroTagPrefix ?? ''}-',
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: UiUtils.calculateColumns(
              context: context,
              itemWidth: 200,
              minValue: 1,
              maxValue: 8,
            ),
            childAspectRatio: 0.667,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
      ),
    );
  }
}

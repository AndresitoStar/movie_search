import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/ui/icons.dart';

class ItemListPage extends StatelessWidget {
  final List<BaseSearchResult> items;
  final String title;
  final String? heroTagPrefix;

  const ItemListPage({Key? key, required this.items, required this.title, this.heroTagPrefix}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        primary: true,
        titleSpacing: 0,
        elevation: 0,
        leading: IconButton(icon: Icon(MyIcons.arrow_left), onPressed: () => Navigator.of(context).pop()),
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
            crossAxisCount: getColumns(context), childAspectRatio: 0.667, crossAxisSpacing: 10, mainAxisSpacing: 10),
      ),
    );
  }

  int getColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width ~/ 150).clamp(1, 6);
  }
}

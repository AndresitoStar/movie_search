import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/trending/trending_viewmodel.dart';
import 'package:movie_search/modules/trending/viewmodel/trending_filter_viewmodel.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class TrendingPage extends StatelessWidget {
  final TrendingViewModel param;

  const TrendingPage({Key key, @required this.param}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ViewModelBuilder<TrendingViewModel>.reactive(
        viewModelBuilder: () => TrendingViewModel.forPage(param.content, param.items, param.total, context.read()),
        builder: (context, viewModel, child) => Scaffold(
              appBar: AppBar(
                title: Text(viewModel.content.title),
                primary: true,
                titleSpacing: 0,
                elevation: 0,
                actions: [
                  // if (viewModel.content == TrendingContent.MOVIE)
                  //   IconButton(
                  //     icon: Icon(
                  //       MyIcons.calendar,
                  //     ),
                  //     onPressed: () => showYearFilter(context, viewModel),
                  //   ),
                  // IconButton(
                  //   icon: Icon(
                  //     viewModel.activeGenres.length > 0
                  //         ? Icons.filter_list_alt
                  //         : MyIcons.filter,
                  //   ),
                  //   onPressed: () =>
                  //       showFilters(context, param.content.type, viewModel),
                  // ),
                ],
                bottom: viewModel.activeGenres.length > 0
                    ? PreferredSize(
                        preferredSize: Size.fromHeight(kToolbarHeight),
                        child: Container(
                          height: kToolbarHeight,
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            physics: ClampingScrollPhysics(),
                            separatorBuilder: (context, index) => Container(width: 10),
                            scrollDirection: Axis.horizontal,
                            itemCount: viewModel.activeGenresNames.length,
                            itemBuilder: (context, i) => Chip(label: Text(viewModel.activeGenresNames[i])),
                          ),
                        ),
                      )
                    : null,
                leading: IconButton(
                  icon: Icon(MyIcons.arrow_left),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              body: viewModel.isBusy
                  ? Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: viewModel.items.length + 2,
                      itemBuilder: (ctx, i) => i < viewModel.items.length
                          ? ItemGridView(item: viewModel.items[i], showData: false)
                          : viewModel.hasMore
                              ? Builder(
                                  builder: (context) {
                                    if (i == viewModel.items.length) viewModel.fetchMore();
                                    return GridItemPlaceholder();
                                  },
                                )
                              : Container(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: getColumns(context),
                          childAspectRatio: 5 / 9,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                    ),
            ));
  }

  int getColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width ~/ 150).clamp(1, 8);
  }

  showYearFilter(BuildContext context, TrendingViewModel viewModel) async {
    final dateTime = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Seleccione el año'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Limpiar'),
              // style: ButtonStyle(
              //   foregroundColor:
              //       MaterialStateProperty.all<Color>(Colors.white70),
              // ),
              // style: ButtonStyle(textStyle),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cerrar'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
            ),
          ],
          content: AspectRatio(
            aspectRatio: 2 / 3,
            child: YearPicker(
              firstDate: DateTime(1890, 1),
              lastDate: DateTime(DateTime.now().year + 1, 1),
              initialDate: DateTime.now(),
              selectedDate: DateTime(viewModel.year ?? DateTime.now().year),
              onChanged: (DateTime dateTime) {
                Navigator.pop(context, dateTime);
              },
            ),
          ),
        );
      },
    );
    if (dateTime != null && dateTime is DateTime)
      viewModel.updateYear(dateTime?.year);
    else if (dateTime is bool) viewModel.updateYear(null);
  }

  showFilters(BuildContext context, String type, TrendingViewModel viewModel) async {
    final result = await showModalBottomSheet<Map<String, bool>>(
      context: context,
      // backgroundColor: Theme.of(context).primaryColor,
      isDismissible: false,
      builder: (BuildContext context) => ViewModelBuilder<TrendingFilterViewModel>.reactive(
        viewModelBuilder: () => new TrendingFilterViewModel(context.read(), type, viewModel.filterGenre),
        createNewModelOnInsert: true,
        builder: (context, model, _) => model.isBusy
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Géneros de ${param.content.title}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            iconSize: 20,
                            icon: Icon(MyIcons.clean),
                            onPressed: () => model.clear(),
                          ),
                          IconButton(
                            iconSize: 32,
                            onPressed: () => Navigator.of(context).pop(model.filterGenre),
                            icon: Icon(MyIcons.check, color: Colors.green),
                          ),
                          IconButton(
                            iconSize: 32,
                            color: Colors.red,
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(MyIcons.clear),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 16,
                        runSpacing: 20,
                        children: model.genres
                            .map(
                              (e) => ElevatedButton(
                                onPressed: () => model.toggle(e.id),
                                style: ElevatedButton.styleFrom(
                                  primary: model.filterGenre[e.id]
                                      ? Theme.of(context).primaryColorDark
                                      : Theme.of(context).colorScheme.background,
                                  elevation: 5,
                                ),
                                child: Text(
                                  e.name,
                                  style: TextStyle(
                                      color: model.filterGenre[e.id]
                                          ? Theme.of(context).colorScheme.onPrimary
                                          : Theme.of(context).colorScheme.onBackground),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
    if (result != null) viewModel.updateFilters(result);
  }
}

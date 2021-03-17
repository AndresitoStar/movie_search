import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/trending/trending_viewmodel.dart';
import 'package:movie_search/modules/trending/viewmodel/trending_filter_viewmodel.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';

class TrendingPage extends StatelessWidget {
  final TrendingViewModel param;

  const TrendingPage({Key key, @required this.param}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final theme = Theme.of(context);
    return ViewModelBuilder<TrendingViewModel>.reactive(
        viewModelBuilder: () => TrendingViewModel.forPage(
            param.content, param.items, param.total, context.read()),
        builder: (context, viewModel, child) => SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(viewModel.content.title),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  titleSpacing: 0,
                  elevation: 0,
                  actions: [
                    IconButton(
                      icon: Icon(
                        MyIcons.filter,
                        color: viewModel.activeGenres.length > 0
                            ? theme.accentColor
                            : theme.iconTheme.color,
                      ),
                      onPressed: () =>
                          showFilters(context, param.content.type, viewModel),
                    ),
                  ],
                  bottom: viewModel.activeGenres.length > 0
                      ? PreferredSize(
                          preferredSize: Size.fromHeight(kToolbarHeight),
                          child: Container(
                            height: kToolbarHeight,
                            child: ListView.separated(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              physics: ClampingScrollPhysics(),
                              separatorBuilder: (context, index) =>
                                  Container(width: 10),
                              scrollDirection: Axis.horizontal,
                              itemCount: viewModel.activeGenresNames.length,
                              itemBuilder: (context, i) => Chip(
                                  label: Text(viewModel.activeGenresNames[i])),
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
                            ? ItemGridView(
                                item: viewModel.items[i], showData: false)
                            : viewModel.hasMore
                                ? Builder(
                                    builder: (context) {
                                      if (i == viewModel.items.length)
                                        viewModel.fetchMore();
                                      return GridItemPlaceholder();
                                    },
                                  )
                                : Container(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                orientation == Orientation.portrait ? 2 : 3,
                            childAspectRatio: 5 / 9,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                      ),
              ),
            ));
  }

  showFilters(
      BuildContext context, String type, TrendingViewModel viewModel) async {
    final result = await showModalBottomSheet<Map<String, bool>>(
      context: context,
      isDismissible: false,
      builder: (BuildContext context) =>
          ViewModelBuilder<TrendingFilterViewModel>.reactive(
        viewModelBuilder: () => new TrendingFilterViewModel(
            context.read(), type, viewModel.filterGenre),
        createNewModelOnInsert: true,
        builder: (context, model, _) => model.isBusy
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
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
                            onPressed: () =>
                                Navigator.of(context).pop(model.filterGenre),
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
                        children: model.genres
                            .map((e) => ElevatedButton(
                                  onPressed: () => model.toggle(e.id),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              model.filterGenre[e.id]
                                                  ? Colors.orange
                                                  : Colors.black45),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ))),
                                  child: Text(e.name),
                                ))
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

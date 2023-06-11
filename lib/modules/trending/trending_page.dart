import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/trending/trending_viewmodel.dart';
import 'package:movie_search/modules/trending/viewmodel/trending_filter_viewmodel.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class TrendingPage extends StatelessWidget {
  final TrendingViewModel param;

  const TrendingPage({Key? key, required this.param}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TrendingViewModel>.reactive(
        viewModelBuilder: () => TrendingViewModel.forPage(param.content, param.items, param.total, context.read(),
            filterGenre: param.filterGenre),
        builder: (context, viewModel, child) => Scaffold(
              appBar: AppBar(
                title: Text(
                    '${viewModel.content.title}${param.activeGenresNames.isNotEmpty ? ' de ' + param.activeGenresNames.first : ''}'),
                primary: true,
                titleSpacing: 0,
                elevation: 0,
                leading: IconButton(icon: Icon(MyIcons.arrow_left), onPressed: () => Navigator.of(context).pop()),
              ),
              body: viewModel.isBusy
                  ? Center(child: CircularProgressIndicator())
                  : MasonryGridView.count(
                      padding: const EdgeInsets.all(10.0),
                      itemCount: viewModel.items.length + 2,
                      crossAxisCount: getColumns(context),
                      itemBuilder: (ctx, i) => AspectRatio(
                        aspectRatio: 0.667,
                        child: i < viewModel.items.length
                            ? ItemGridView(
                                item: viewModel.items[i],
                                showData: false,
                                showTitles: param.content == TrendingContent.PERSON,
                                heroTagPrefix: '',
                              )
                            : viewModel.hasMore
                                ? Builder(
                                    builder: (context) {
                                      if (i == viewModel.items.length) viewModel.fetchMore();
                                      return GridItemPlaceholder();
                                    },
                                  )
                                : Container(),
                      ),
                    ),
            ));
  }

  int getColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width ~/ 150).clamp(1, 8);
  }

  showFilters(BuildContext context, String type, TrendingViewModel viewModel) async {
    final result = await showModalBottomSheet<Map<String, bool>>(
      context: context,
      // colorScheme.background: Theme.of(context).primaryColor,
      isDismissible: false,
      builder: (BuildContext context) => ViewModelBuilder<TrendingFilterViewModel>.reactive(
        viewModelBuilder: () => new TrendingFilterViewModel(context.read(), type, viewModel.filterGenre!),
        createNewViewModelOnInsert: true,
        builder: (context, model, _) => model.isBusy
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Géneros de ${param.content.title}',
                        style: Theme.of(context).textTheme.titleLarge,
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
                                  backgroundColor: model.filterGenre[e.id]!
                                      ? Theme.of(context).primaryColorDark
                                      : Theme.of(context).colorScheme.background,
                                  elevation: 5,
                                ),
                                child: Text(
                                  e.name,
                                  style: TextStyle(
                                      color: model.filterGenre[e.id]!
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

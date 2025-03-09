import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_ui_util.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_watch_providers.dart';
import 'package:stacked/stacked.dart';

class ItemWatchProvidersView extends StackedView<ItemWatchProviderViewModel> {
  final String type;
  final num id;

  ItemWatchProvidersView({required this.type, required this.id, super.key});

  @override
  Widget builder(BuildContext context, ItemWatchProviderViewModel viewModel, Widget? child) {
    return viewModel.isBusy
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: LinearProgressIndicator(),
          )
        : viewModel.hasError && viewModel.provider.every((element) => element.providerName != null)
            ? IconButton(onPressed: viewModel.futureToRun, icon: Icon(Icons.update))
            : viewModel.provider.isEmpty
                ? Container()
                : ContentHorizontal(
                    padding: 8,
                    label: 'Disponible en',
                    forceLight: true,
                    subtitle: LogosWidget(
                        list: viewModel.provider.map((e) => MapEntry(e.providerName!, e.logoPath)).toList()),
                  );
  }

  @override
  ItemWatchProviderViewModel viewModelBuilder(BuildContext context) => ItemWatchProviderViewModel(id: id, type: type);
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_search/modules/account/viewModel/account_viewmodel.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/audiovisual/componets/item_list_page.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/favourite/viewmodel/favourite_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/routes.dart';
import 'package:movie_search/ui/frino_icons.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/dialogs.dart';
import 'package:movie_search/ui/widgets/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:stacked/stacked.dart';

class FavouriteScreen extends ViewModelWidget<FavouritesViewModel> {
  static String routeName = "/favourite";

  @override
  Widget build(BuildContext context, FavouritesViewModel model) {
    final landscape = MediaQuery.of(context).size.aspectRatio > 0.7;

    return Consumer<AccountViewModel>(
      builder: (context, provider, child) {
        return CustomScaffold(
          bottomBarIndex: 3,
          body: Stack(
            fit: StackFit.expand,
            children: [
              NestedScrollView(
                headerSliverBuilder: (context, value) {
                  return [
                    SliverAppBar(
                      floating: false,
                      snap: false,
                      pinned: true,
                      // elevation: 0,
                      primary: true,
                      title: Text('Favoritos'),
                      leading: IconButton(
                        icon: Icon(MyIcons.arrow_left),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      titleSpacing: 0,
                      toolbarHeight: landscape ? 0 : kToolbarHeight,
                      bottom: PreferredSize(
                        preferredSize: Size(double.infinity, !provider.isLogged ? 1 : kToolbarHeight),
                        child: provider.isLogged
                            ? ListTile(
                                leading: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(provider.photoUrl ?? ''),
                                  ),
                                ),
                                title: Text(provider.displayName ?? 'Usuario'),
                                tileColor: Theme.of(context).secondaryHeaderColor,
                                trailing: IconButton(onPressed: provider.logout, icon: Icon(FrinoIcons.f_logout)),
                              )
                            : Container(),
                      ),
                    ),
                  ];
                },
                body: !provider.isLogged
                    ? Center(child: MyGoogleButton())
                    : model.favoriteMap.isEmpty
                        ? _buildEmptyList()
                        : GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
                            itemCount: model.favoriteMap.length,
                            itemBuilder: (ctx, i) => _buildItemList(context, model.favoriteMap.entries.toList()[i]),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: getColumns(context),
                                childAspectRatio: 1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                          ),
              ),
              if (provider.isBusy)
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                    color: Theme.of(context).colorScheme.background.withOpacity(0.7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyLoadingIndicator(size: 25.w),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildItemList(BuildContext context, MapEntry<String, List<BaseSearchResult?>> entry) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        Routes.defaultRoute(
          null,
          ItemListPage(
            items: entry.value as List<BaseSearchResult>,
            title: entry.key,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          border: Border.all(color: Theme.of(context).highlightColor),
        ),
        child: Stack(
          children: [
            GridView.builder(
              itemCount: 4,
              padding: EdgeInsets.zero,
              itemBuilder: (ctx, i) => entry.value.length > i
                  ? ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3, tileMode: TileMode.decal),
                      child: Image.network('${URL_IMAGE_MEDIUM}${entry.value[i]?.posterImage}', fit: BoxFit.fitWidth))
                  : Container(color: Theme.of(context).canvasColor),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Theme.of(context).colorScheme.background.withOpacity(0.8),
                child: ListTile(
                  title: Text(entry.key, style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyList() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(MyIcons.favourite_off, size: 64),
          SizedBox(height: 25.0),
          Text('No tienes Favoritas todavía.'),
        ],
      ),
    );
  }

  int getColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return (width ~/ 160).clamp(1, 6);
  }
}

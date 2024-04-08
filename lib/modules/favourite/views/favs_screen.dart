import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_search/modules/account/viewModel/account_viewmodel.dart';
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
          title: 'Mis Favoritos',
          forceAppbar: true,
          body: provider.isBusy
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              borderRadius: BorderRadius.circular(40.w),

                              child: provider.photoUrl != null
                                  ? Image.network(
                                      provider.photoUrl!,
                                      fit: BoxFit.fill,
                                      width: 40.w,
                                    )
                                  : Icon(
                                      Icons.account_circle,
                                      size: 40.w,
                                    ),
                            ),
                          ),
                          if (provider.isLogged) ...[
                            Center(
                              child: Text(provider.displayName ?? 'Usuario',
                                  style: Theme.of(context).textTheme.headlineSmall),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: provider.logout,
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                              child: Text(
                                'Cerrar Sesion',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
                              ),
                            ),
                          ] else
                            MyGoogleButton(),
                        ],
                      ),
                    ),
                    if (model.favoriteMap.isNotEmpty)
                      Expanded(
                        flex: 1,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: ClampingScrollPhysics(),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ...model.favoriteMap.entries
                                  .map(
                                    (e) => AspectRatio(
                                      aspectRatio: 1,
                                      child: _buildItemList(context, e),
                                    ),
                                  )
                                  .toList(),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 30),
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
          fit: StackFit.expand,
          children: [
            // GridView.builder(
            //   itemCount: 4,
            //   padding: EdgeInsets.zero,
            //   itemBuilder: (ctx, i) => entry.value.length > i
            //       ? ImageFiltered(
            //           imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3, tileMode: TileMode.decal),
            //           child: Image.network('${URL_IMAGE_MEDIUM}${entry.value[i]?.posterImage}', fit: BoxFit.fitWidth))
            //       : Container(color: Theme.of(context).canvasColor),
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     childAspectRatio: 1,
            //     crossAxisSpacing: 1,
            //     mainAxisSpacing: 1,
            //   ),
            // ),
            entry.value.first?.posterImage != null
                ? ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3, tileMode: TileMode.decal),
                    child: Image.network('${URL_IMAGE_MEDIUM}${entry.value.first?.posterImage}', fit: BoxFit.cover))
                : Container(color: Theme.of(context).canvasColor),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Theme.of(context).colorScheme.background.withOpacity(0.8),
                child: ListTile(
                  title: Text(entry.key, style: TextStyle(color: Theme.of(context).colorScheme.onBackground)),
                  subtitle: Text(
                    '${entry.value.length} elementos',
                    style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
                  ),
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

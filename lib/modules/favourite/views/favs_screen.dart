import 'dart:ui';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/modules/account/viewModel/account_viewmodel.dart';
import 'package:movie_search/modules/audiovisual/componets/item_list_page.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/favourite/viewmodel/favourite_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/routes.dart';
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
          bottomBarIndex: 2,
          title: 'Mis Favoritos',
          forceAppbar: true,
          actions: [
            if (provider.isLogged)
              IconButton(
                onPressed: () => MyDialogs.showConfirmationDialog(
                  context,
                  title: 'Cerrar Sesión',
                  message: '¿Estás seguro de que deseas cerrar la sesión?',
                  onConfirm: () {
                    provider.logout();
                  },
                ),
                icon: Icon(Icons.logout_outlined),
                color: Colors.red,
              ),
          ],
          body: provider.isBusy
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    const SizedBox(height: 20),
                    if (provider.isLogged) ...[
                      Center(
                        child: Card(
                          elevation: 5,
                          clipBehavior: Clip.hardEdge,
                          shape: CircleBorder(),
                          child: ClipOval(
                            child: provider.photoUrl != null
                                ? Image.network(
                                    provider.photoUrl!,
                                    width: 8.h,
                                    fit: BoxFit.cover,
                                  )
                                : Icon(
                                    Icons.account_circle,
                                    size: 8.h,
                                  ),
                          ),
                        ),
                      ),
                      Text(
                        provider.displayName ?? 'Usuario',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Divider(),
                    ] else
                      MyGoogleButton(),
                    Expanded(
                      child: model.favoriteMap.isEmpty
                          ? _buildEmptyList()
                          : GridView.builder(
                              padding: EdgeInsets.all(10),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: getColumns(context),
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: model.favoriteMap.length,
                              itemBuilder: (ctx, i) {
                                final entry =
                                    model.favoriteMap.entries.elementAt(i);
                                return _buildItemList(context, entry);
                              },
                            ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildItemList(
      BuildContext context, MapEntry<String, List<BaseSearchResult?>> entry) {
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
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: context.theme.colorScheme.onSurface.withValues(alpha: 0.1),
          border: Border.all(
            color: context.theme.colorScheme.onSurface.withValues(alpha: 0.1),
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            entry.value.first?.posterImage != null
                ? Image.network(
                    '${URL_IMAGE_MEDIUM}${entry.value.first?.posterImage}',
                    fit: BoxFit.cover)
                : Container(color: Theme.of(context).canvasColor),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color:
                    Theme.of(context).colorScheme.surface.withOpacity(0.99),
                child: ListTile(
                  title: Text(entry.key.capitalize,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface)),
                  subtitle: Text(
                    '${entry.value.length} elementos',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
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

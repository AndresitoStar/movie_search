import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_search/modules/account/viewModel/account_viewmodel.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/favourite/viewmodel/favourite_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
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
                                leading: Image.network(provider.photoUrl ?? ''),
                                title: Text(provider.displayName ?? 'Usuario'),
                                trailing: IconButton(onPressed: provider.logout, icon: Icon(FrinoIcons.f_logout)),
                              )
                            : Container(),
                      ),
                    ),
                  ];
                },
                body: !provider.isLogged
                    ? Center(child: MyGoogleButton())
                    : model.favoriteList.isEmpty
                        ? _buildEmptyList()
                        : GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            itemCount: model.favoriteList.length,
                            itemBuilder: (ctx, i) => ItemGridView(item: model.favoriteList[i]!, heroTagPrefix: ''),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: getColumns(context),
                                childAspectRatio: 0.667,
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

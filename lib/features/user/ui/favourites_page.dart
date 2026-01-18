import 'package:flutter/material.dart';
import 'package:movie_search/common/route_page.dart';

class FavouritesPage extends StatelessWidget {
  static String routeName = "/profile";
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RoutePage(
      title: 'Favourites',
      routeNames: [
        '/:type/:id',
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_search/common/route_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const RoutePage(
      title: 'Profile',
      routeNames: [
        '/:type/:id',
        'favourites',
      ],
    );
  }
}

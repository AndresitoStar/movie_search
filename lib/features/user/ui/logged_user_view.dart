import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/ui/dialogs.dart';
import 'package:movie_search/features/user/provider/user.dart';
import 'package:movie_search/features/user/ui/bookmarks_list.dart';

class LoggedUserView extends ConsumerWidget {
  const LoggedUserView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        spacing: 8,
        children: [
          Text('Welcome, here is your profile', style: context.textTheme.headlineMedium, textAlign: TextAlign.center),
          ElevatedButton.icon(
            onPressed: () => MyDialogs.showConfirmationDialog(
              context,
              title: 'Cerrar Sesión',
              message: '¿Estás seguro de que deseas cerrar la sesión?',
              onConfirm: () {
                ref.read(userProvider.notifier).signOut();
              },
            ),
            label: Text('Logout'),
            icon: Icon(Icons.logout_outlined),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
          ),
          BookmarksListView(),
        ],
      ),
    );
  }
}

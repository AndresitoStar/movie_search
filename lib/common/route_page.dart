import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';

class RoutePage extends StatelessWidget {
  final String title;
  final List<String> routeNames;

  const RoutePage({super.key, required this.title, required this.routeNames});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: context.theme.primaryColor),
      body: ListView.builder(
        itemCount: routeNames.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(routeNames[index]),
              onTap: () {
                context.push(routeNames[index]);
              },
            ),
          );
        },
      ),
    );
  }
}

import 'package:movie_search/providers/game_single_provider.dart';
import 'package:movie_search/providers/games_provider.dart';
import '../screens/game_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameListItem extends StatelessWidget {
  final _types = {
    'movie': 'Película',
    'series': 'Serie',
    'episode': 'Programa de TV'
  };

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameProvider>(context, listen: false);
    final provider = Provider.of<GameListProvider>(context, listen: false);

    return Card(
      elevation: 5,
      child: ListTile(
        onTap: () {
//          Navigator.of(context).pushNamed(GameDetail.routeName,
//              arguments: game.id);
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                      value: game, child: GameDetail())))
              .then((v) {
            provider.loadFavorites(context);
            FocusScope.of(context).requestFocus(FocusNode());
          });
        },
//        leading: game.imageUrl != null
//            ? Image.network(
//                game.imageUrl,
//                fit: BoxFit.fill,
//              )
//            : backFlipCard(game),
//        trailing: Consumer<GameProvider>(
//            builder: (ctx, product, child) => IconButton(
//                icon: product.isFavourite
//                    ? Icon(Icons.favorite, color: Colors.red)
//                    : Icon(Icons.favorite_border, color: Colors.red),
//                onPressed: () => product.toggleFavourite(),
//                color: Theme.of(context).accentColor)),
        title: Text('${game.title} (${game.year})',
            style: Theme.of(context).textTheme.title),
        subtitle: Text('${game.platforms}', // \n ${game.year}
            style: Theme.of(context).textTheme.subtitle),
      ),
    );
  }
}

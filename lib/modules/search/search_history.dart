import 'package:flutter/material.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:stacked/stacked.dart';

class SearchHistoryViewModel extends StreamViewModel<List<String>> {
  @override
  Stream<List<String>> get stream =>
      SharedPreferencesHelper.getInstance().streamForSearchHistory;
}

// View
class SearchHistoryView extends StatelessWidget {
  final Function(String) onTap;

  const SearchHistoryView({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchHistoryViewModel>.reactive(
      builder: (context, model, child) =>
          model.data != null && model.data.isNotEmpty
              ? ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: model.data.length,
                  itemBuilder: (context, i) => ListTile(
                    onTap: () => onTap(model.data[i]),
                    leading: Icon(MyIcons.history),
                    trailing: Icon(Icons.north_west),
                    title: Text(
                      model.data[i],
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                )
              : Container(
                  child: Center(child: Text('No has buscado nada todavía...')),
                ),
      viewModelBuilder: () => SearchHistoryViewModel(),
    );
  }
}

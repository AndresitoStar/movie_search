import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_like_button.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_ui_util.dart';
import 'package:movie_search/modules/person/viewmodel/person_detail_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

class PersonDetailContent extends ViewModelWidget<PersonDetailViewModel> {
  final bool isSliver;

  PersonDetailContent({this.isSliver = true});

  @override
  Widget build(BuildContext context, PersonDetailViewModel viewModel) {
    final item = viewModel.data;
    final children = <Widget>[
      Hero(
        tag: 'title-${item.id}',
        child: Material(
          color: Colors.transparent,
          child: Text(
            item.name,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(color: Theme.of(context).accentColor),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (item.birthday != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '${item.birthday ?? ''} - ${item.deathday ?? 'actualidad'}',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.subtitle1),
                Text('Edad: ${viewModel.age()} años',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.subtitle1),
              ],
            ),
          ItemLikeButton(id: item.id, type: TMDB_API_TYPE.PERSON, iconSize: 45),
        ],
      ),
      ContentDivider(value: item.biography),
      ContentHorizontal(content: item.biography),
      ContentRow(
        label1: 'Conocida por',
        label2: 'Lugar de Nacimiento',
        value1: item.knownForDepartment,
        value2: item.placeOfBirth,
      ),
    ];
    return isSliver
        ? SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
            sliver: SliverList(delegate: SliverChildListDelegate(children)))
        : Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
          child: Column(
              children: children,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
            ),
        );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_ui_util.dart';
import 'package:movie_search/modules/audiovisual/componets/item_recomendation_horizontal_list.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_recomendations_viewmodel.dart';
import 'package:movie_search/modules/person/viewmodel/person_detail_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';

class PersonDetailContent extends ViewModelWidget<PersonDetailViewModel> {
  @override
  Widget build(BuildContext context, PersonDetailViewModel viewModel) {
    final item = viewModel.data;
    return SliverPadding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
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
              if (item.birthday != null)
                Text(
                    '${item.birthday ?? ''} - ${item.deathday ?? 'actualidad'}',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1),
              // Text( //TODO Edad
              //     '${item.birthday ?? ''} - ${item.deathday ?? 'actualidad'}',
              //     textAlign: TextAlign.center,
              //     style: Theme.of(context).textTheme.subtitle1),
              ContentDivider(value: item.biography),
              ContentHorizontal(content: item.biography),
              ContentRow(
                label1: 'Conocida por',
                label2: 'Lugar de Nacimiento',
                value1: item.knownForDepartment,
                value2: item.placeOfBirth,
              ),
            ],
          ),
        ));
  }
}

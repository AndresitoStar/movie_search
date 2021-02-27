import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/item_detail_like_button.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_detail_viewmodel.dart';
import 'package:movie_search/modules/person/components/person_horizontal_list.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:stacked/stacked.dart';

import 'item_detail_ui_util.dart';

class ItemDetailContent extends ViewModelWidget<ItemDetailViewModel> {
  @override
  Widget build(BuildContext context, viewModel) {
    final item = viewModel.data;
    return SliverPadding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'title-${item.id}',
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Theme.of(context).accentColor),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: item.titleOriginal != item.title,
                    child: Text(
                      '(${item.titleOriginal})',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(fontStyle: FontStyle.italic, fontSize: 16),
                    ),
                  ),
                  Visibility(
                    visible: item.data != null,
                    child: ListTile(
                      title: Text('${item.data?.anno} / ${item.data?.genre}'),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Row(
                      children: [
                        Icon(MyIcons.imdb, color: Colors.orange, size: 60),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              item.data?.score ?? '${item.voteAverage ?? ''}',
                              style: Theme.of(context).textTheme.headline4),
                        ),
                        Expanded(child: Container()),
                        ItemLikeButton(
                          id: viewModel.data.id,
                          type: viewModel.data.type,
                        )
                      ],
                    ),
                  ),
                  item.data == null ? LinearProgressIndicator() : Container(),
                  if (item.data?.tagline != null &&
                      item.data.tagline.isNotEmpty)
                    ListTile(
                      title: Text(
                        item.data?.tagline,
                        style: Theme.of(context).textTheme.caption.copyWith(
                            fontSize: 16, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ContentHorizontal(content: item.data?.sinopsis),
                  Divider(),
                  CreditHorizontalList(item.type, item.id),
                  ContentRow(
                    label1: 'Pais',
                    label2: 'Idioma',
                    value1: item.data?.pais,
                    value2: item.data?.idioma,
                  ),
                  ContentDivider(value: item.data?.director),
                  ContentHorizontal(
                      label: 'Director', content: item.data?.director),
                  ContentRow(
                    label1: 'Temporadas',
                    label2: 'Capitulos',
                    value1: item.data?.temp,
                    value2: item.data?.capitulos,
                  ),
                  ContentRow(
                    label1: 'Año',
                    label2: 'Duración',
                    value1: item.data?.anno,
                    value2: item.data?.duracion != null
                        ? '${item.data?.duracion} minutos'
                        : null,
                  ),
                  ContentDivider(value: item.data?.productora),
                  ContentHorizontal(
                      label: 'Productora', content: item.data?.productora),
                ],
              ),
            ],
          ),
        ));
  }
}

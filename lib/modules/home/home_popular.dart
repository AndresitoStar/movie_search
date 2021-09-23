import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/componets/item_grid_view.dart';
import 'package:movie_search/modules/home/home_screen_content_indicator.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:stacked/stacked.dart';

import 'home_screen_viewmodel.dart';

class HomePopularWidget extends ViewModelWidget<HomeScreenViewModel> {
  const HomePopularWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeScreenViewModel model) {
    final theme = Theme.of(context);
    return ReactiveForm(
      formGroup: model.form,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: [
                Text('Popular', style: Theme.of(context).textTheme.headline5),
                Spacer(),
                HomeScreenContentIndicator(),
              ],
            ),
          ),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ReactiveFormConsumer(
              builder: (context, formGroup, child) => Container(
                child: model.popularMap == null
                    ? Center(child: CircularProgressIndicator(strokeWidth: 1))
                    : CarouselSlider(
                        items: model.popularMap
                            .map((i) => ItemGridView(
                                  item: i,
                                  showData: false,
                                  useBackdrop: true,
                                ))
                            .toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          disableCenter: true,
                          reverse: false,
                          autoPlay: false,
                          enlargeCenterPage: false,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
              ),
            ),
          ),
          if (model.genresMap.isNotEmpty) ...[
            SizedBox(height: 10),
            ReactiveFormField(
              formControl: model.typeControl,
              builder: (typeField) => Container(
                height: 32,
                child: ReactiveFormField<GenreTableData, GenreTableData>(
                  formControl: model.genreControl,
                  // builder: (genreField) => SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   physics: ClampingScrollPhysics(),
                  //   child: CupertinoSegmentedControl(
                  //     groupValue: genreField.control.value,
                  //     borderColor: theme.colorScheme.onBackground,
                  //     children: Map.fromIterable(model.genresMap[typeField.control.value],
                  //         key: (element) => element as GenreTableData,
                  //         value: (element) => Text((element as GenreTableData).name)),
                  //     onValueChanged: (value) => model.selectGenre(value),
                  //   ),
                  // ),
                  builder: (genreField) => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: ClampingScrollPhysics(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...model.genresMap[typeField.value]
                            .map((g) => Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 2),
                                  child: g.id == genreField.value?.id
                                      ? ElevatedButton(
                                          child: Text(g.name),
                                          onPressed: () => null,
                                        )
                                      : TextButton(
                                          child: Text(g.name),
                                          onPressed: () => model.selectGenre(g),
                                        ),
                                ))
                            .toList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

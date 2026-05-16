import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_search/common/domain/search_result.dart';
import 'package:movie_search/common/model/person.dart';
import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/common/provider/infinite_scroll_content_provider.dart';
import 'package:movie_search/common/ui/content_preview_horizontal_list.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/item_grid_view.dart';

class CreditsHorizontal extends ContentPreviewViewMoreWidget {
  final num id;
  final String type;

  CreditsHorizontal({required this.id, required this.type, super.key}) {
    super.apiParams = {ApiParams.id: id.toString(), ApiParams.type: type};
  }

  @override
  ContentConfig get config => ContentConfig.credits;

  @override
  String get itemGridHeroTag => 'content_credit_item';

  @override
  // TODO: implement pageRouteName
  String get pageRouteName => throw UnimplementedError();

  @override
  String get title => 'Elenco';

  @override
  String get viewMoreButtonHeroTag => 'content_credit_view_more';

  @override
  TMDB_API_TYPE? get forcedType => TMDB_API_TYPE.PERSON;

  @override
  bool get itemShowTitle => true;

  @override
  bool get canNavigate => false;

  @override
  ContentPreviewMode get mode => ContentPreviewMode.grid;

  @override
  Widget Function(BuildContext context, BaseSearchResult item)? get gridItemBuilder {
    return (context, item) {
      return ItemGridListTilePerson(
        item: item,
        heroTagPrefix: itemGridHeroTag,
      );
    };
  }
}

class PersonHorizontalList extends ContentPreviewViewMoreWidget {
  final List<Person> persons;
  final String tag;

  PersonHorizontalList({required this.persons, required this.tag, super.key});

  @override
  ContentConfig get config => ContentConfig.none;

  @override
  String get itemGridHeroTag => tag;

  @override
  // TODO: implement pageRouteName
  String get pageRouteName => throw UnimplementedError();

  @override
  String get title => 'Creadores';

  @override
  String get viewMoreButtonHeroTag => 'content_credit_view_more';

  @override
  List<BaseSearchResult> get items {
    return persons.map((e) => BaseSearchResult.fromPerson(e)).toList();
  }

  @override
  TMDB_API_TYPE? get forcedType => TMDB_API_TYPE.PERSON;

  @override
  bool get itemShowTitle => true;

  @override
  bool get canNavigate => false;
}

class RecommendationsHorizontal extends ContentPreviewViewMoreWidget {
  final num id;
  final String type;

  RecommendationsHorizontal({required this.id, required this.type, super.key}) {
    super.apiParams = {ApiParams.id: id.toString(), ApiParams.type: type};
  }

  @override
  ContentConfig get config => ContentConfig.recommendations;

  @override
  String get itemGridHeroTag => 'content_recommendations_item';

  @override
  // TODO: implement pageRouteName
  String get pageRouteName => throw UnimplementedError();

  @override
  String get title => 'Recomendaciones';

  @override
  String get viewMoreButtonHeroTag => 'content_recommendations_view_more';

  @override
  bool get itemShowTitle => true;

  @override
  bool get canNavigate => false;
}

class PersonCreditsHorizontal extends ContentPreviewViewMoreWidget {
  final num id;

  PersonCreditsHorizontal({required this.id, super.key}) {
    super.apiParams = {ApiParams.id: id.toString()};
  }

  @override
  ContentConfig get config => ContentConfig.personCredits;

  @override
  String get itemGridHeroTag => 'content_persons_credit_item';

  @override
  // TODO: implement pageRouteName
  String get pageRouteName => throw UnimplementedError();

  @override
  String get title => 'Ha participado en';

  @override
  TextStyle? get titleTextStyle => TextStyle(fontSize: 12, fontWeight: FontWeight.w600);

  @override
  String get viewMoreButtonHeroTag => 'content_persons_credit_view_more';

  @override
  bool get itemShowTitle => true;

  @override
  bool get canNavigate => false;

}
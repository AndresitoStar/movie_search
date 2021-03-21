import 'package:flutter/material.dart';
import 'package:movie_search/data/moor_database.dart';
import 'package:movie_search/modules/audiovisual/componets/item_recomendation_horizontal_list.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/item_recomendations_viewmodel.dart';
import 'package:movie_search/modules/person/components/person_detail_appbar.dart';
import 'package:movie_search/modules/person/components/person_detail_content.dart';
import 'package:movie_search/modules/person/components/person_detail_main_image.dart';
import 'package:movie_search/modules/person/viewmodel/person_detail_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class PersonDetailScreen extends StatelessWidget {
  final Person param;

  const PersonDetailScreen({Key key, @required this.param}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final landscape = MediaQuery.of(context).size.aspectRatio > 0.7;
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => PersonDetailViewModel(param, context.read()),
      builder: (context, model, _) => SafeArea(
        child: Scaffold(
          floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            floatingActionButton: landscape ? FloatingActionButton.extended(
              onPressed: () => Navigator.of(context).pop(),
              label: Text('ATRAS'),
              icon: Icon(MyIcons.arrow_left),
            ) : null,
          body: model.hasError
              ? Center(
                  child: Text('${model.modelError?.toString()}'),
                )
              : landscape
                  ? _buildLandScape(context, model)
                  : CustomScrollView(
                      controller: model.scrollController,
                      slivers: <Widget>[
                        PersonDetailSliverAppBar(),
                        if (model.initialised) PersonDetailContent(),
                        if (model.initialised)
                          ItemDetailRecommendationHorizontalList(
                            TMDB_API_TYPE.PERSON.type,
                            param.id,
                            ERecommendationType.Credit,
                          ),
                      ],
                    ),
        ),
      ),
    );
  }

  _buildLandScape(BuildContext context, PersonDetailViewModel model) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width / 2.5),
          child: Container(
            alignment: Alignment.center,
            child: AspectRatio(
              aspectRatio: 9 / 16,
              child: PersonDetailMainImage(landscape: true),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: model.scrollController,
            child: Column(
              children: [
                if (model.initialised) PersonDetailContent(isSliver: false),
                if (model.initialised)
                  ItemDetailRecommendationHorizontalList(
                    TMDB_API_TYPE.PERSON.type,
                    param.id,
                    ERecommendationType.Credit,
                    sliver: false,
                  ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

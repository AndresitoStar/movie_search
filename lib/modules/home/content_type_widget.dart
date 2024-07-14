import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_search/core/content_type_controller.dart';
import 'package:movie_search/modules/home/home_screen.dart';
import 'package:movie_search/providers/util.dart';
import 'package:stacked/stacked.dart';
import 'package:get_it/get_it.dart';

class ContentTypeViewModel extends BaseViewModel {
  late TMDB_API_TYPE type;

  loadCurrentType() async {
    setBusy(true);
    type = ContentTypeController.getInstance().currentType;
    setBusy(false);
    setInitialised(true);
  }

  updateCurrentType(TMDB_API_TYPE type) async {
    ContentTypeController.getInstance().updateCurrentType(type);
    this.type = type;
    notifyListeners();
  }
}

class ContentTypeWidget extends StatelessWidget {
  const ContentTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ContentTypeViewModel>.reactive(
      viewModelBuilder: () => ContentTypeViewModel(),
      onViewModelReady:  (model) => model.loadCurrentType(),
      builder: (context, model, child) {
        return PopupMenuButton<TMDB_API_TYPE>(
          initialValue: model.type,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(model.type.nameSingular),
              Icon(Icons.arrow_drop_down),
            ],
          ),
          onSelected: (TMDB_API_TYPE result) {
            model.updateCurrentType(result);
            GetIt.instance<HomeController>().loading();
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<TMDB_API_TYPE>>[
            PopupMenuItem(
              value: TMDB_API_TYPE.MOVIE,
              child: Text(TMDB_API_TYPE.MOVIE.nameSingular),
            ),
            PopupMenuItem(
              value: TMDB_API_TYPE.TV_SHOW,
              child: Text(TMDB_API_TYPE.TV_SHOW.nameSingular),
            ),
          ],
        );
      },
    );
  }

}

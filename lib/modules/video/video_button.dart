import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/video/video_screen.dart';
import 'package:movie_search/modules/video/video_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/frino_icons.dart';
import 'package:stacked/stacked.dart';

class VideoButton extends StatelessWidget {
  final BaseSearchResult param;

  const VideoButton({Key? key, required this.param}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VideoViewModel>.reactive(
      viewModelBuilder: () => VideoViewModel(param.type.type, param.id),
      builder: (context, model, _) => !model.initialised || model.isBusy
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: CircularProgressIndicator(strokeWidth: 1),
            )
          : !model.hasVideos
              ? Container()
              : IconButton(
                  onPressed: model.hasVideos
                      ? () => Navigator.of(context).pushNamed(VideoScreen.route, arguments: [model.videos, param.title])
                      : null,
                  icon: Icon(FrinoIcons.f_video),
                  color: Theme.of(context).colorScheme.onSurface,
                  disabledColor: Theme.of(context).hintColor,
                ),
    );
  }
}

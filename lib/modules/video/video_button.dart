import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/video/dialog_video.dart';
import 'package:movie_search/modules/video/video_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/icons.dart';
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
          : IconButton(
              onPressed: model.hasVideos
                  ? () => DialogVideo.show(context: context, videos: model.videos, dialogTitle: param.title)
                  : null,
              icon: Icon(MyIcons.youtube),
              color: Colors.red,
              disabledColor: Theme.of(context).hintColor,
            ),
    );
  }
}

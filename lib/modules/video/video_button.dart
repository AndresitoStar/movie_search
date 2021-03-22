import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/video/dialog_video.dart';
import 'package:movie_search/modules/video/video_viewmodel.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/circular_button.dart';
import 'package:stacked/stacked.dart';
import 'package:movie_search/providers/util.dart';

class VideoButton extends StatelessWidget {
  final BaseSearchResult param;

  const VideoButton({Key key, this.param}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ViewModelBuilder<VideoViewModel>.reactive(
        viewModelBuilder: () => VideoViewModel(param.type.type, param.id),
        builder: (context, model, _) => model.isBusy
            ? Container(
                height: 30,
                width: 30,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: CircularProgressIndicator.adaptive(strokeWidth: 1),
              )
            : model.hasError
                ? Icon(MyIcons.error)
                : !model.hasVideos
                    ? Container()
                    : IconButton(
                        color: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        icon: Icon(MyIcons.youtube),
                        onPressed: () => DialogVideo.show(
                          context: context,
                          videos: model.videos,
                          dialogTitle: param.title,
                        ),
                      ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/video/dialog_video.dart';
import 'package:movie_search/modules/video/video_viewmodel.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:stacked/stacked.dart';
import 'package:movie_search/providers/util.dart';

class VideoButton extends StatelessWidget {
  final BaseSearchResult param;

  const VideoButton({Key key, this.param}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VideoViewModel>.reactive(
      viewModelBuilder: () => VideoViewModel(param.type.type, param.id),
      builder: (context, model, _) => TextButton.icon(
        onPressed: !model.isBusy && !model.hasError && model.hasVideos
            ? () => DialogVideo.show(
                  context: context,
                  videos: model.videos,
                  dialogTitle: param.title,
                )
            : null,
        icon: Icon(
          MyIcons.youtube,
          color: !model.isBusy && !model.hasError && model.hasVideos ? Colors.red : Theme.of(context).hintColor,
        ),
        label: Text('Ver Trailers'),
        // child: model.isBusy
        //     ? Container(
        //         height: 24,
        //         width: 24,
        //         margin: const EdgeInsets.symmetric(horizontal: 8),
        //         child: CircularProgressIndicator.adaptive(strokeWidth: 1),
        //       )
        //     : Row(
        //         mainAxisSize: MainAxisSize.min,
        //         children: [
        //         ],
        //       ),
      ),
    );
  }
}

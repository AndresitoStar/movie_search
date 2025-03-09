import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/video/video_viewmodel.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/frino_icons.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../model/api/models/video.dart';

class VideosCarousel extends StatelessWidget {
  final BaseSearchResult param;

  const VideosCarousel({Key? key, required this.param}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VideoViewModel>.reactive(
      viewModelBuilder: () => VideoViewModel(param.type.type, param.id),
      builder: (context, model, _) => !model.initialised ||
              model.isBusy ||
              !model.hasVideos
          ? Container()
          : Container(
              height: 60,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: model.videos.length,
                itemBuilder: (ctx, i) => Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.network(
                            model.videos[i].youtubeThumbnail,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: InkWell(
                            onTap: model.videos[i].isYoutube
                                ? () => _launchYoutubeVideo(model.videos[i])
                                : null,
                            child: ClipRRect(
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                                child: Container(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surface
                                      .withOpacity(0.25),
                                  child: Icon(
                                    FrinoIcons.f_play,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.65),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

Future<void> _launchYoutubeVideo(Video v) async {
  final url = 'https://www.youtube.com/watch?v=${v.key}';
  // final Uri _url = Uri.parse(url);

  // if (await canLaunchUrlString(url)) {
  await launchUrlString(url, mode: LaunchMode.externalApplication);
  // } else {
  //   throw 'Could not launch $url';
  // }
}

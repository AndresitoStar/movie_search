import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_search/core/content_preview.dart';
import 'package:movie_search/model/api/models/video.dart';
import 'package:movie_search/ui/frino_icons.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:url_launcher/url_launcher_string.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({Key? key}) : super(key: key);

  static String route = '/videoScreen';

  @override
  Widget build(BuildContext context) {
    final List arguments = ModalRoute.of(context)!.settings.arguments as List;
    final List<Video> videosList = arguments[0];
    final String title = arguments[1] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(icon: Icon(MyIcons.arrow_left), onPressed: () => Navigator.of(context).pop()),
        titleSpacing: 0,
        elevation: 0,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: UiUtils.calculateColumns(context: context, itemWidth: 150, minValue: 1, maxValue: 8),
          childAspectRatio: 16 / 9,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: videosList.length,
        itemBuilder: (context, i) => Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                videosList[i].youtubeThumbnail,
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              left: 0,
              child: InkWell(
                onTap: videosList[i].isYoutube ? () => _launchYoutubeVideo(videosList[i]) : null,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                    child: Container(
                      color: Theme.of(context).colorScheme.background.withOpacity(0.25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Icon(
                              FrinoIcons.f_play,
                              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.65),
                            ),
                          ),
                          if (videosList[i].name != null)
                            Container(
                              color: Theme.of(context).colorScheme.tertiaryContainer,
                              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                              child: Text(
                                videosList[i].name ?? '',
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Theme.of(context).colorScheme.onTertiaryContainer),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
}

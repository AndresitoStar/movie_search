import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_search/model/api/models/video.dart';
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
          crossAxisCount: 3,
          childAspectRatio: 16 / 9,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
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
              child: GestureDetector(
                onTap: videosList[i].isYoutube ? () => _launchYoutubeVideo(videosList[i]) : null,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: Container(
                      color: Theme.of(context).colorScheme.background.withOpacity(0.25),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.play_circle_outline,
                            size: 64,
                            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.65),
                          ),
                          Chip(
                            backgroundColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.85),
                            label: Text(
                              videosList[i].name ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Theme.of(context).colorScheme.background),
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
    await launchUrlString(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}

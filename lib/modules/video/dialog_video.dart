import 'package:flutter/material.dart';
import 'package:movie_search/model/api/models/video.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DialogVideo extends StatelessWidget {
  final List<Video> videos;
  final String? dialogTitle;

  DialogVideo({
    Key? key,
    required this.videos,
    this.dialogTitle,
  }) : super(key: key);

  static Future show({
    required BuildContext context,
    required videos,
    dialogTitle,
  }) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, __, ___) => DialogVideo(
        videos: videos,
        dialogTitle: dialogTitle,
      ),
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: this.dialogTitle != null
            ? Text(
                dialogTitle!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              )
            : null,
        children: [
          ...videos
              .map<Widget>((v) => InkWell(
                    onTap: () => _launchYoutubeVideo(v),
                    child: Card(
                      color: Colors.black26,
                      elevation: 0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      child: ListTile(
                        leading:
                            Icon(v.isYoutube ? MyIcons.youtube : MyIcons.video),
                        title: Text(
                          v.name ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // subtitle: Text(v.site),
                      ),
                    ),
                  ))
              .toList(),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red)),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cerrar'))
              ],
            ),
          )
        ]);
  }

  Future<void> _launchYoutubeVideo(Video v) async {
    final url = 'https://www.youtube.com/watch?v=${v.key}';

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

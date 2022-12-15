import 'package:flutter/material.dart';
import 'package:movie_search/modules/person/viewmodel/social_viewmodel.dart';
import 'package:movie_search/ui/icons.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SocialView extends StatelessWidget {
  final String type;
  final num typeId;

  const SocialView(this.type, this.typeId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SocialViewModel>.reactive(
      viewModelBuilder: () => SocialViewModel(this.type, this.typeId),
      builder: (context, model, _) {
        if (model.isBusy)
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SizedBox(width: 100, child: LinearProgressIndicator()),
          );
        if (model.hasError)
          return IconButton(
              onPressed: model.futureToRun, icon: Icon(Icons.refresh));
        return ButtonBar(
          alignment: MainAxisAlignment.start,
          buttonPadding: EdgeInsets.zero,
          children: [
            if (model.social?.facebookId != null)
              IconButton(
                onPressed: () => launchUrlString(
                    'https://www.facebook.com/${model.social!.facebookId}'),
                icon: Icon(MyIcons.facebook, color: Color(0xff4267b2)),
              ),
            if (model.social?.instagramId != null)
              IconButton(
                onPressed: () => launchUrlString(
                    'https://www.instagram.com/${model.social!.instagramId}'),
                icon: Image.asset('assets/images/instagram.png', width: 24),
              ),
            if (model.social?.twitterId != null)
              IconButton(
                onPressed: () => launchUrlString(
                    'https://www.twitter.com/${model.social!.twitterId}'),
                icon: Icon(MyIcons.twitter, color: Color(0xff00acee)),
              ),
          ],
        );
      },
    );
  }
}

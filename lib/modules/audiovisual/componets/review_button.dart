import 'package:flutter/material.dart';
import 'package:movie_search/modules/audiovisual/componets/review_page.dart';
import 'package:movie_search/modules/audiovisual/model/base.dart';
import 'package:movie_search/modules/audiovisual/viewmodel/review_view_model.dart';
import 'package:movie_search/providers/util.dart';
import 'package:movie_search/ui/frino_icons.dart';
import 'package:stacked/stacked.dart';

class ReviewButton extends StatelessWidget {
  final BaseSearchResult param;

  const ReviewButton({Key? key, required this.param}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReviewViewModel>.reactive(
      viewModelBuilder: () => ReviewViewModel(type: param.type.type, id: param.id),
      builder: (context, model, _) => !model.initialised || model.isBusy
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: CircularProgressIndicator(strokeWidth: 1),
            )
          : !model.hasReviews
              ? Container()
              : Badge(
                  label: Text(
                    '${model.badgeLabel}',
                    style: context.theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                  backgroundColor: Colors.redAccent,
                  alignment: Alignment.topRight,
                  offset: Offset(-1, 5),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pushNamed(ReviewPage.routeName, arguments: param),
                    icon: Icon(FrinoIcons.f_chat_text),
                    color: Theme.of(context).colorScheme.onBackground,
                    disabledColor: Theme.of(context).hintColor,
                  ),
                ),
    );
  }
}

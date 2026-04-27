import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_search/common/domain/search_result.dart';
import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/common/ui/frino_icons.dart';
import 'package:movie_search/features/audiovisual/provider/audiovisual_provider.dart';

class VideoButton extends ConsumerWidget {
  final BaseSearchResult param;

  const VideoButton({super.key, required this.param});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videos = ref.watch(fetchVideosProvider(param.id, param.type.type));

    return videos.isLoading
        ? Padding(padding: const EdgeInsets.all(12.0), child: CircularProgressIndicator(strokeWidth: 1))
        : !videos.hasValue || videos.value!.results.isEmpty || videos.hasError
        ? Container()
        : IconButton(
            onPressed: _onPressed(context),
            icon: Icon(FrinoIcons.f_video),
            color: Theme.of(context).colorScheme.onSurface,
            disabledColor: Theme.of(context).hintColor,
          );
  }

  _onPressed(BuildContext context) {
    return context.push('videos', extra: param);
  }
}

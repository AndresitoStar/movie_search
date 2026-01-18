import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/domain/paginated_state.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/model/tmdb_type.dart';
import 'package:movie_search/common/route_page.dart';
import 'package:movie_search/common/ui/scaffold.dart';
import 'package:movie_search/features/audiovisual/ui/pages/basic_list.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/item_grid_view.dart';
import 'package:movie_search/features/discover/provider/discover_provider.dart';
import 'package:movie_search/features/discover/ui/discover_filter.dart';
import 'package:movie_search/features/home/provider/home_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'discover_results.dart';

class DiscoverPage extends ConsumerStatefulWidget {
  const DiscoverPage({super.key});

  static String routeName = "/discover";

  @override
  ConsumerState<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends ConsumerState<DiscoverPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final notifier = ref.read(discoverProvider.notifier);
      final state = ref.read(discoverProvider);

      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 300 && !state.isLoading) {
        notifier.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomBarIndex: 1,
      body: Column(
        children: [
          DiscoverFilterBar(),
          Expanded(child: DiscoverResults(controller: _scrollController)),
        ],
      ),
      appBar: CustomScaffoldAppbar(bottomBarIndex: 1, title: Text('Descubrir')),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

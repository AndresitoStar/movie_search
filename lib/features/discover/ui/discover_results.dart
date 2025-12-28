import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/domain/paginated_state.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/features/audiovisual/ui/pages/basic_list.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/item_grid_view.dart';
import 'package:movie_search/features/discover/provider/discover_provider.dart';
import 'package:movie_search/features/home/provider/home_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DiscoverResults extends ConsumerWidget {
  const DiscoverResults({super.key, required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(discoverProvider);
    final isMobile = Device.deviceType == DeviceType.android || Device.deviceType == DeviceType.ios;

    ref.listen(discoverFilterProvider, (previous, next) {
      ref.read(discoverProvider.notifier).refresh();
    });

    return state is InitialPaginatedState
        ? Center(child: Icon(Icons.image_search_rounded, size: 64, color: context.colors.onBackground.withOpacity(0.3)))
        : state.items.isEmpty && state.isLoading
        ? const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          )
        : state.items.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: .center,
              children: [
                Icon(Icons.featured_play_list_outlined, size: 64, color: context.colors.onBackground.withOpacity(0.3)),
                SizedBox(height: 20),
                Text('Sin resultados', style: context.textTheme.titleLarge),
              ],
            ),
          )
        : Scrollbar(
            thumbVisibility: !isMobile,
            controller: controller,
            child: NotificationListener<ScrollNotification>(
              onNotification: (scroll) {
                if (scroll.metrics.pixels >= scroll.metrics.maxScrollExtent - 200) {
                  ref.read(discoverProvider.notifier).loadMore();
                }
                return false;
              },
              child: RefreshIndicator(
                onRefresh: () => ref.read(discoverProvider.notifier).refresh(),
                child: GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  controller: controller,
                  itemCount: state.itemCount + 1,
                  itemBuilder: (ctx, i) {
                    if (i == state.itemCount) {
                      return const Center(
                        child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator()),
                      );
                    }
                    return ItemGridView(
                      item: state.items[i],
                      showType: false,
                      showTitles: true,
                      heroTagPrefix: '$i-discover-list-',
                    );
                  },
                  gridDelegate: gridDelegate(context),
                ),
              ),
            ),
          );
  }
}

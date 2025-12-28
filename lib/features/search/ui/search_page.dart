import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/domain/paginated_state.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/ui/utils.dart';
import 'package:movie_search/features/audiovisual/ui/widgets/item_list_view.dart';
import 'package:movie_search/features/search/provider/search_provider.dart';
import 'package:movie_search/features/search/ui/search_bar.dart' as sb;
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  static void showDialog(BuildContext context) {
    showBlurDialog(
      context: context,
      child: Dialog(
        child: SizedBox(
          // constraints: BoxConstraints(maxWidth: Adaptive.px(500)),
          height: 80.h,
          width: 80.w,
          child: SearchPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Device.screenType == ScreenType.mobile;
    return Scaffold(
      appBar: AppBar(
        title: Text('Busqueda'),
        automaticallyImplyLeading: isMobile,
        actions: [
          if (!isMobile)
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + 8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: sb.SearchBar(hint: 'Buscar películas, series, personas...'),
          ),
        ),
      ),
      body: SearchResults(),
    );
  }
}

class SearchResults extends ConsumerWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchProvider);
    final isMobile = Device.deviceType == DeviceType.android || Device.deviceType == DeviceType.ios;
    final controller = ScrollController();

    return state is InitialSearchPaginatedState
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
                  ref.read(searchProvider.notifier).loadMore();
                }
                return false;
              },
              child: ListView.separated(
                itemCount: state.items.length + 1,
                separatorBuilder: (context, index) => Container(height: 1, color: context.theme.dividerColor),
                controller: controller,
                itemBuilder: (context, index) {
                  if (index == state.items.length) {
                    return state.isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : const SizedBox.shrink();
                  }

                  final item = state.items[index];
                  return SearchResultListItem(searchResult: item, conpactMode: true, searchCriteria: state.query);
                },
              ),
            ),
          );
  }
}
